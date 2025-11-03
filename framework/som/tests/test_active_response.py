#!/usr/bin/env python
# Copyright (C) 2015, Som Inc.
# Created by Som, Inc. <info@som.com>.
# This program is free software; you can redistribute it and/or modify it under the terms of GPLv2

import os
import sys
from json import dumps
from unittest.mock import patch, MagicMock

import pytest

with patch('som.core.common.som_uid'):
    with patch('som.core.common.som_gid'):
        sys.modules['som.rbac.orm'] = MagicMock()
        import som.rbac.decorators
        from som.tests.util import RBAC_bypasser

        del sys.modules['som.rbac.orm']
        som.rbac.decorators.expose_resources = RBAC_bypasser

        from api.util import remove_nones_to_dict
        from som.active_response import run_command
        from som.core.tests.test_active_response import agent_config
        from som.core.tests.test_agent import InitAgent

test_data = InitAgent()
test_data_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'data', 'etc', 'shared', 'ar.conf')
full_agent_list = {'000', '001', '002', '003', '004', '005', '006', '007', '008'}


def send_msg_to_wdb(msg, raw=False):
    query = ' '.join(msg.split(' ')[2:])
    result = list(map(remove_nones_to_dict, map(dict, test_data.cur.execute(query).fetchall())))
    return ['ok', dumps(result)] if raw else result

# Tests

@pytest.mark.parametrize('message_exception, send_exception, agent_list, command, arguments, alert', [
    (1650, None, ['001'], None, [], None),
    (1652, None, ['002'], 'random', [], None),
    (1701, None, ['999'], 'random', [], None),
    (None, 1707, ['004'], 'restart-som0', [], None),
    (None, None, ['006'], 'restart-som0', [], None),
    (None, None, ['006'], '!custom-ar', [], None),
    (None, None, ['007'], 'restart-som0', ["arg1", "arg2"], None),
    (None, None, ['001', '002', '003', '004', '005', '006'], 'restart-som0', [], None),
    (None, None, ['001'], 'restart-som0', ["arg1", "arg2"], None),
    (None, None, ['002'], 'restart-som0', [], None),
])
@patch("som.core.som_queue.SomQueue._connect")
@patch("som.syscheck.SomQueue._send", return_value='1')
@patch("som.core.som_queue.SomQueue.close")
@patch('som.core.common.AR_CONF', new=test_data_path)
@patch('som.active_response.get_agents_info', return_value=full_agent_list)
@patch('som.core.wdb.SomDBConnection._send', side_effect=send_msg_to_wdb)
@patch('socket.socket.connect')
def test_run_command(socket_mock, send_mock, mock_get_agents_info, mock_close, mock_send, mock_conn, message_exception,
                     send_exception, agent_list, command, arguments, alert):
    """Verify the proper operation of active_response module.

    Parameters
    ----------
    message_exception : int
        Exception code expected when calling create_message.
    send_exception : int
        Exception code expected when calling send_command.
    agent_list : list
        Agents on which to execute the active response command.
    command : string
        Command to be executed on the agent.
    arguments : list
        Arguments of the command.
    custom : boolean
        True if command is a script.
    version : list
        List with the agent version to test whether the message sent was the correct one or not.
    """
    with patch('som.core.agent.Agent.get_config', return_value=agent_config(send_exception)):
        ret = run_command(agent_list=agent_list, command=command, arguments=arguments, alert=alert)
        render = ret.render()
        message = 'AR command was not sent to any agent'

        if message_exception:
            assert render['data']['failed_items'][0]['error']['code'] == message_exception
        elif send_exception:
            assert render['data']['failed_items'][0]['error']['code'] == send_exception
        else:
            if len(render['data']['failed_items']) != 0:
                message = 'AR command was not sent to some agents'
            else:
                message = 'AR command was sent to all agents'
        
        assert render['message'] == message
