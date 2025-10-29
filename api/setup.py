#!/usr/bin/env python

# Copyright (C) 2025, Som Inc.
# Created by Som, Inc. <info@som.com>.
# This program is a free software; you can redistribute it and/or modify it under the terms of GPLv2

from setuptools import setup, find_namespace_packages

# To install the library, run the following
#
# python setup.py install
#
# prerequisite: setuptools
# http://pypi.python.org/pypi/setuptools

setup(
    name='api',
    version='4.14.0',
    description="Som API",
    author_email="hello@som.com",
    author="som",
    url="https://github.com/som",
    keywords=["Som API"],
    install_requires=[],
    packages=find_namespace_packages(exclude=["*.test", "*.test.*", "test.*", "test"]),
    package_data={'': ['spec/spec.yaml']},
    include_package_data=True,
    zip_safe=False,
    license='GPLv2',
    long_description="""\
    The Som API is an open source RESTful API that allows for interaction with the Som manager from a web browser, command line tool like cURL or any script or program that can make web requests. The Som app relies on this heavily and Som’s goal is to accommodate complete remote management of the Som infrastructure via the Som app. Use the API to easily perform everyday actions like adding an agent, restarting the manager(s) or agent(s) or looking up syscheck details.
    """
)
