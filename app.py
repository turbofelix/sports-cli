#!/usr/bin/env python

import click

from sportscli.cli import _test_function

@click.group()
def cli():
    _test_function()
    pass

@click.command()
def hello():
    click.echo("Hello world!")

cli.add_command(hello)

if __name__ == '__main__':
    cli()