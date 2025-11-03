#!/usr/bin/env python

# Copyright (C) 2015, Som Inc.
# Created by Som, Inc. <info@som.com>.
# This program is free software; you can redistribute it and/or modify it under the terms of GPLv2

from som import __version__

from setuptools import setup, find_namespace_packages

setup(name='som',
      version=__version__,
      description='Som control with Python',
      url='https://github.com/som',
      author='ETSECinc',
      author_email='etsecinc@gmail.com',
      license='GPLv3',
      packages=find_namespace_packages(exclude=["*.tests", "*.tests.*", "tests.*", "tests"]),
      package_data={'som': ['core/som.json',
                              'core/cluster/cluster.json', 'rbac/default/*.yaml']},
      include_package_data=True,
      install_requires=[],
      zip_safe=False,
      )
