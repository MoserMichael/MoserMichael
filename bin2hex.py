#!/usr/bin/env python3

import argparse
import sys

def parse_cmd_line():
    usage = """
Convert bin to hex
"""

    parse = argparse.ArgumentParser(
        description=usage, formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )

    parse.add_argument('--infile', '-i', type=str, default="", \
            dest='infile', help='input file that contains some file')

    parse.add_argument('--outfile', '-o', type=str, default="", \
            dest='outfile', help='output file that will get the input file in hexadecimal text')

    return parse.parse_args(), parse


def convert_fun(in_file_name, out_file_name):
    with open(in_file_name,'rb') as in_file:

        hex_bytes = in_file.read()

        with open(out_file_name, 'w') as out_file:
            out_file.write(hex_bytes.hex())

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


