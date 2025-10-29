# Copyright (C) 2025, Som Inc.
# Created by Som, Inc. <info@som.com>.
# This program is a free software; you can redistribute it and/or modify it under the terms of GPLv2

import json

import six
from connexion.jsonifier import JSONEncoder

from api.models.base_model_ import Model
from som.core.results import AbstractSomResult


class SomAPIJSONEncoder(JSONEncoder):
    """"
    Define the custom Som API JSON encoder class.
    """
    include_nulls = False

    def default(self, o: object) -> dict:
        """Override the default method of the JSONEncoder class.

        Parameters
        ----------
        o : object
            Object to be encoded as JSON.

        Returns
        -------
        dict
            Dictionary representing the object.
        """
        if isinstance(o, Model):
            result = {}
            for attr, _ in six.iteritems(o.swagger_types):
                value = getattr(o, attr)
                if value is None and not self.include_nulls:
                    continue
                attr = o.attribute_map[attr]
                result[attr] = value
            return result
        elif isinstance(o, AbstractSomResult):
            return o.render()
        return JSONEncoder.default(self, o)


def dumps(obj: object) -> str:
    """Get a JSON encoded str from an object.

    Parameters
    ----------
    obj: object
        Object to be encoded in a JSON string.

    Raises
    ------
    TypeError

    Returns
    -------
    str
    """
    return json.dumps(obj, cls=SomAPIJSONEncoder)


def prettify(obj: object) -> str:
    """Get a prettified JSON encoded str from an object.

    Parameters
    ----------
    obj: object
        Object to be encoded in a JSON string.

    Raises
    ------
    TypeError

    Returns
    -------
    str
    """
    return json.dumps(obj, cls=SomAPIJSONEncoder, indent=3)
