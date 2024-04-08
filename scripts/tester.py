#!/usr/bin/env python3
#
# Adapted script from "Konstrukcja kompilatorow" course.
#

import argparse
import glob
import os
import sys
import subprocess
import shutil

class Configuration:
    def __init__(self, apk, testdir, algorithm, workdir):
        self.apk = apk
        self.testdir = testdir
        self.workdir = workdir
        self.algorithm = algorithm

    def printself(self):
        print('Configuration:')
        print(' - apk:       ', self.apk)
        print(' - testdir:   ', self.testdir)
        print(' - workdir:   ', self.workdir)
        if self.algorithm is None:
            print(' - algorithm: ', '<default>')
        else:
            print(' - algorithm: ', self.algorithm)

class LineUtils:
    @staticmethod
    def enumlist(xs):
        "converts any iterable into list and adds positions"
        xs = list(xs)
        for i in range(0, len(xs)):
            xs[i] = (i+1, xs[i])
        return xs

    @staticmethod
    def prepare(xs):
        lines = LineUtils.enumlist(xs)
        lines = [ (l[0], l[1].strip()) for l in lines ]
        lines = [ l for l in lines if len(l[1]) > 0 ]
        return lines

class ResultTable:
    def __init__(self, table):
        self.table = table

    @staticmethod
    def readFile(path):
        def throwerror(i, msg):
            raise Exception("error in line %i: %s" % (i,msg))

        with open(path) as f:
            lines = LineUtils.prepare(f.readlines())
            return ResultTable.readLines(lines)

    @staticmethod
    def readLines(lines):
        def throwerror(i, msg):
            raise Exception("error in line %i: %s" % (i,msg))

        def extract_string(keyword, xline):
            i = xline[0]
            line = xline[1]
            if not line.startswith(keyword):
                throwerror(i, "expected `%s`, not `%s`" % (keyword, line))
            
            line = line[len(keyword):].strip()
            if len(line) < 2:
                throwerror(i, "cannot parse data")
            
            if line[0] != "'":
                throwerror(i, "data string should start with ' (apostrophe)")
            if line[-1] != "'":
                throwerror(i, "data string should end with ' (apostrophe)")

            return line[1:-1]

        def readentry(table, label_line, in_line, out_line):
            label_name = extract_string("label", label_line)
            if label_name in table:
                throwerror(i, "label '%s' is already described" % label_name)
            in_data = extract_string("in:", in_line)
            out_data = extract_string("out:", out_line)

            table[label_name] = (in_data, out_data)

        n = len(lines)
        if n % 3 != 0:
            raise Exception("Something is weird, number of lines should be multiplication of 3 (each entry is described by 3 lines)")
        n = n // 3
        table = {}
        for i in range(0, n):
            c = 3*i
            readentry(table, lines[c], lines[c+1], lines[c+2])

        return ResultTable(table)

    def print(self):
        for k in self.table:
            print('label %s in %s out %s' % (k, self.table[k][0], self.table[k][1]))

    class ComparisonResult:
        def __init__(self):
            self.extra_labels = set()
            self.missing_labels = set()
            self.wrong_input = []
            self.wrong_output = []

        def is_ok(self):
            if len(self.missing_labels) > 0: return False
            if len(self.extra_labels) > 0: return False
            if len(self.wrong_input) > 0: return False
            if len(self.wrong_output) > 0: return False
            return True

        def formatmsg(self):
            xs = ["invalid analysis result:"]
            if len(self.missing_labels) > 0:
                xs += ["missing labels: " + ", ".join(self.missing_labels)]
            if len(self.extra_labels) > 0: 
                xs += ["extra labels: " + ", ".join(self.extra_labels)]
            for label, expected, actual in self.wrong_input:
                xs += ["wrong input for label %s:" % label]
                xs += ["  expected: '%s'" % expected]
                xs += ["  actual:   '%s'" % actual]
            for label, expected, actual in self.wrong_output:
                xs += ["wrong output for label %s:" % label]
                xs += ["  expected: '%s'" % expected]
                xs += ["  actual:   '%s'" % actual]
            return "\n".join(xs)

    @staticmethod
    def compare(expected, actual):
        result = ResultTable.ComparisonResult()
        expected = expected.table
        actual = actual.table
        expected_labels = set(expected.keys())
        actual_labels = set(actual.keys())
        
        result.extra_labels = actual_labels - expected_labels
        result.missing_labels = expected_labels - actual_labels

        common_labels = expected_labels & actual_labels

        for label in common_labels:
            expected_in, expected_out = expected[label]
            actual_in, actual_out = actual[label]

            if expected_in != actual_in:
                result.wrong_input.append((label, expected_in, actual_in))
            if expected_out != actual_out:
                result.wrong_output.append((label, expected_out, actual_out))

        return result


class TestOutput:
    class Status:
        PROGRAM_FAILURE = 0
        RESULT_MISMATCH = 1
        SUCCESS = 2

    def __init__(self):
        self.status = None
        self.stdout = None
        self.stderr = None
        self.ok = None
        self.table = None


class TestInstrumentation:
    def __init__(self, test):
        self.test = test
        self.expected_result_table = None
        self.analysis = None
        self.language = None
        self.env = {}

        try:
            self.parse()
            self.validate()
        except Exception as e:
            raise Exception("test %s: %s" % (self.test, str(e)))

    def content(self):
        # get content of all comments started with //@
        with open(self.test) as f:
            lines = LineUtils.prepare(f.readlines())
            lines = [ line for line in lines if line[1].startswith("//@") ]
            lines = [ (line[0], line[1][3:].strip()) for line in lines ]
            return lines

    def parse(self):
        content = self.content()
        instrumented = "PRACOWNIA" in map(lambda x: x[1], content)
        if not instrumented:
            raise Exception('Test instrumentation is missing: %s' % self.test)

        tableLines = []

        for xline in content:
            line = xline[1].strip()
            if line == "PRACOWNIA":
                pass
            elif line.startswith("analysis"):
                if self.analysis is not None:
                    raise Exception("duplicated @analysis")
                self.analysis = line.split()[1]
            elif line.startswith("language"):
                if self.language is not None:
                    raise Exception("duplicated @language")
                self.language = line.split()[1]
            elif line.startswith("label"):
                tableLines.append(xline)
            elif line.startswith("in:"):
                tableLines.append(xline)
            elif line.startswith("out:"):
                tableLines.append(xline)
            else:
                raise Exception("invalid test instrumentation: unknown directive: " + line)

        self.expected_result_table = ResultTable.readLines(tableLines)

    def validate(self):
        if self.analysis is None:
            raise Exception("missing @analysis")
        if self.language is None:
            raise Exception("missing @language")


class Test:
    def __init__(self, test, instrumentation):
        self.test = test
        self.instrumentation = instrumentation

class ExpectationMatcher:
    def __init__(self, test , output):
        self.test = test
        self.output = output 

    def __match_output(self):
        if self.output.table is None:
            return False, "output table does not exist"
        if not isinstance(self.output.table, ResultTable):
            return None, "internal error: result table is of invalid type: " + str(type(self.output.table))

        cmpresult = ResultTable.compare(self.test.instrumentation.expected_result_table, self.output.table)

        if not cmpresult.is_ok():
            return False, cmpresult.formatmsg()

        return True, ""

    def match(self):
        try:
            if not self.output.ok:
                return False, "unable to execute apk"

            if len(self.output.stderr) > 0:
                return False, "stderr is not empty: " + str(self.output.stderr, encoding='utf-8')

            return self.__match_output()
        except Exception as e:
            return None, "cannot check result: " + str(e)

class TestRawExecutor:
    def __init__(self, conf, test, language, analysis, output_file):
        self.conf = conf
        self.test = test
        self.language = language
        self.analysis = analysis
        self.output_file = output_file
        self.test_output = TestOutput()

    def execute(self):
        self.prepare_env()
        ok, stdout, stderr = self.compile_program() 
        self.test_output.stdout = stdout
        self.test_output.stderr = stderr
        self.test_output.ok = ok
        if ok and os.path.exists(self.output_file):
            self.test_output.table = ResultTable.readFile(self.output_file)
        self.clean_env()
        return self.test_output

    def compile_program(self):
        xs = [self.conf.apk, self.language, 'analyse']
        xs.append(self.analysis)
        if self.conf.algorithm is not None:
            xs.append('--algorithm')
            xs.append(self.conf.algorithm)
        xs.append('-t')
        xs.append(self.output_file)
        xs.append(self.test)
        return self.__call(xs)

    def execute_program(self):
        return self.__call([self.conf.spim, '-file', self.output_file])

    def prepare_env(self):
        shutil.rmtree(self.conf.workdir, ignore_errors=True)
        os.makedirs(self.conf.workdir)

    def clean_env(self):
        shutil.rmtree(self.conf.workdir, ignore_errors=True)

    def __call(self, xs, extenv={}):
        env = os.environ
        for k in extenv:
            env[k] = extenv[k]

        try:
            p = subprocess.Popen(xs, stdin=None, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
            stdin, stdout = p.communicate(timeout=5)
            status = p.returncode == 0
            return (status, stdin, stdout)
        except subprocess.TimeoutExpired:
            return (False, [], [])
        except Exception:
            return (False, [], [])

class TestExecutor:
    def __init__(self, test, conf):
        self.test = test
        self.conf = conf
    
    def execute(self):
        try:
            output_file = os.path.join(self.conf.workdir, 'result.table')
            analysis = self.test.instrumentation.analysis
            language = self.test.instrumentation.language
            rawExecutor = TestRawExecutor(self.conf, self.test.test, language, analysis , output_file)
            test_output = rawExecutor.execute()
            matcher = ExpectationMatcher(self.test, test_output)
            return matcher.match()
        except Exception as e:
            raise e


class TestRepository:
    def __init__(self, testdirs):
        self.tests = []
        self.collect_tests(testdirs)

    def collect_tests(self, testdirs):
        testfiles = []
        for testdir in testdirs:
            for path, _, files in os.walk(testdir):
                for file in files:
                    if file.endswith(".tst"):
                        testfiles.append(os.path.join(path, file))
        testfiles = list(sorted(testfiles))

        for testfile in testfiles:
            instrumentation = TestInstrumentation(testfile)
            test = Test(testfile, instrumentation)
            self.tests.append(test)

    def gen(self):
        for t in self.tests:
            yield t


class Application:
    def __init__(self):
        args = self.create_argparse().parse_args()
        self.conf = Configuration(apk=args.apk,
                                  testdir=args.testdir,
                                  algorithm=args.algorithm,
                                  workdir=args.workdir)


    def create_argparse(self):
        parser = argparse.ArgumentParser(description='APK tester')
        parser.add_argument('--apk', help='path to apk binary', default='./_build/install/default/bin/apk', type=str)
        parser.add_argument('--testdir', help='path to test directory', default='./tests', type=str)
        parser.add_argument('--workdir', help='working directory', default='workdir', type=str)
        parser.add_argument('--algorithm', help='algorithm', type=str)
        return parser

    @staticmethod
    def xrun():
        ResultTable.readFile(sys.argv[1]).print()

    def run(self):
        print('APK tester')
        self.conf.printself()
        self.test_repository = TestRepository([self.conf.testdir])
        passed_tests = []
        failed_tests = []
        inconclusive_tests = []
        for test in self.test_repository.gen():
            print('==> running test', test.test)
            executor = TestExecutor(test, self.conf)
            result, explanation = executor.execute()

            if result == None:
                inconclusive_tests.append(test)
                status = "inconclusive: " + explanation
            elif result:
                passed_tests.append(test)
                status = "pass"
            elif not result:
                failed_tests.append(test)
                status = "fail: " + explanation

            print('--- result:', status)
            
        total = len(passed_tests) + len(failed_tests) + len(inconclusive_tests)

        print('===================')
        print('Total: ', total)
        print('Passed:', len(passed_tests))
        print('Inconc:', len(inconclusive_tests))
        print('Failed:', len(failed_tests))
        for test in failed_tests:
            print(' -', test.test)
        if failed_tests != []:
            exit(1)

#Application.xrun()

Application().run()
