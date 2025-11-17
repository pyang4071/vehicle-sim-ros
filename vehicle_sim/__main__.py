#!/usr/bin/env python3

import argparse
import pathlib
import sys


def main():
    parser = argparse.ArgumentParser(
        description="Vehicle simulation via ROS"
    )
    parser.add_argument(
        "-i", "--input", default=pathlib.Path("input.yml"), type=pathlib.Path
    )
    parser.add_argument(
        "-o", "--output", default=pathlib.Path("output.yml"), type=pathlib.Path
    )
    args = parser.parse_args()
    print(args)


if __name__ == "__main__":
    sys.exit(main())
