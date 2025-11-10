# Copyright (C) 2015, Som Inc.
# Created by Som, Inc. <info@som.com>.
# This program is free software; you can redistribute it and/or modify it under the terms of GPLv2

import os
import subprocess
from functools import lru_cache
from sys import exit


@lru_cache(maxsize=None)
def find_som_path() -> str:
    """
    Get the Som installation path.

    Returns
    -------
    str
        Path where Som is installed or empty string if there is no framework in the environment.
    """
    abs_path = os.path.abspath(os.path.dirname(__file__))
    allparts = []
    while 1:
        parts = os.path.split(abs_path)
        if parts[0] == abs_path:  # sentinel for absolute paths
            allparts.insert(0, parts[0])
            break
        elif parts[1] == abs_path:  # sentinel for relative paths
            allparts.insert(0, parts[1])
            break
        else:
            abs_path = parts[0]
            allparts.insert(0, parts[1])

    som_path = ''
    try:
        for i in range(0, allparts.index('wodles')):
            som_path = os.path.join(som_path, allparts[i])
    except ValueError:
        pass

    return som_path


def call_som_control(option: str) -> str:
    """
    Execute the som-control script with the parameters specified.

    Parameters
    ----------
    option : str
        The option that will be passed to the script.

    Returns
    -------
    str
        The output of the call to som-control.
    """
    som_control = os.path.join(find_som_path(), "bin", "som-control")
    try:
        proc = subprocess.Popen([som_control, option], stdout=subprocess.PIPE)
        (stdout, stderr) = proc.communicate()
        return stdout.decode()
    except (OSError, ChildProcessError):
        print(f'ERROR: a problem occurred while executing {som_control}')
        exit(1)


def get_som_info(field: str) -> str:
    """
    Execute the som-control script with the 'info' argument, filtering by field if specified.

    Parameters
    ----------
    field : str
        The field of the output that's being requested. Its value can be 'SOM_VERSION', 'SOM_REVISION' or
        'SOM_TYPE'.

    Returns
    -------
    str
        The output of the som-control script.
    """
    som_info = call_som_control("info")
    if not som_info:
        return "ERROR"

    if not field:
        return som_info

    env_variables = som_info.rsplit("\n")
    env_variables.remove("")
    som_env_vars = dict()
    for env_variable in env_variables:
        key, value = env_variable.split("=")
        som_env_vars[key] = value.replace("\"", "")

    return som_env_vars[field]


@lru_cache(maxsize=None)
def get_som_version() -> str:
    """
    Return the version of Som installed.

    Returns
    -------
    str
        The version of Som installed.
    """
    return get_som_info("SOM_VERSION")


@lru_cache(maxsize=None)
def get_som_revision() -> str:
    """
    Return the revision of the Som instance installed.

    Returns
    -------
    str
        The revision of the Som instance installed.
    """
    return get_som_info("SOM_REVISION")


@lru_cache(maxsize=None)
def get_som_type() -> str:
    """
    Return the type of Som instance installed.

    Returns
    -------
    str
        The type of Som instance installed.
    """
    return get_som_info("SOM_TYPE")


ANALYSISD = os.path.join(find_som_path(), 'queue', 'sockets', 'queue')
# Max size of the event that ANALYSISID can handle
MAX_EVENT_SIZE = 65535
