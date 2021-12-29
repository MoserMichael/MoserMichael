#!/usr/bin/env python3

import argparse
import sys

def parse_cmd_line():
    usage = """
Convert hex to bin
"""

    parse = argparse.ArgumentParser(
        description=usage, formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )

    parse.add_argument('--infile', '-i', type=str, default="", \
            dest='infile', help='input file that contains a hexadecimal string')

    parse.add_argument('--outfile', '-o', type=str, default="", \
            dest='outfile', help='output file that will get the binary data')

    return parse.parse_args(), parse


def convert_fun(in_file_name, out_file_name):
    with open(in_file_name,'r') as in_file:

        in_file_str = in_file.read()
        hex_bytes = bytes.fromhex(in_file_str)

        with open(out_file_name, 'wb') as out_file:
            out_file.write(hex_bytes)

cmd, parse = parse_cmd_line()

if cmd.infile == '':
    print("Error: missing -i argument")
    parse.print_help()
    sys.exit(1)

if cmd.outfile == '':
    print("Error: missing -o argument")
    parse.print_help()
    sys.exit(1)

convert_fun(cmd.infile, cmd.outfile)


