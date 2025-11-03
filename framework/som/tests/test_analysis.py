import sys
from unittest.mock import MagicMock, patch

import pytest

with patch('som.core.common.som_uid'):
    with patch('som.core.common.som_gid'):
        sys.modules['som.rbac.orm'] = MagicMock()
        import som.rbac.decorators

        del sys.modules['som.rbac.orm']

        from som.tests.util import RBAC_bypasser

        som.rbac.decorators.expose_resources = RBAC_bypasser
        from som import analysis

@pytest.mark.asyncio
@patch('som.analysis.node_type', 'master')
@patch('som.analysis.send_reload_ruleset_and_get_results')
async def test_reload_ruleset_master_ok(mock_send_reload_ruleset_msg):
    """Test reload_ruleset() works as expected for master node with successful reload."""
    from som.core.results import AffectedItemsSomResult
    mock_result = AffectedItemsSomResult()
    mock_result.affected_items.append({'name': 'test-node', 'msg': 'ok'})
    mock_result.total_affected_items = 1
    mock_result._failed_items = {}
    mock_send_reload_ruleset_msg.return_value = mock_result

    result = await analysis.reload_ruleset()
    assert isinstance(result, analysis.AffectedItemsSomResult)
    assert result.total_affected_items == 1
    assert result.failed_items == {}


@pytest.mark.asyncio
@patch('som.analysis.node_type', 'master')
@patch('som.analysis.send_reload_ruleset_and_get_results')
async def test_reload_ruleset_master_nok(mock_send_reload_ruleset_msg):
    """Test reload_ruleset() for master node with error in reload."""
    from som.core.results import AffectedItemsSomResult
    mock_result = AffectedItemsSomResult()
    mock_result._failed_items = {'test-node': {'error': 1914}}
    mock_result._total_failed_items = 1
    mock_send_reload_ruleset_msg.return_value = mock_result

    result = await analysis.reload_ruleset()
    assert isinstance(result, analysis.AffectedItemsSomResult)
    assert result.total_failed_items == 1


@pytest.mark.asyncio
@patch('som.analysis.node_type', 'worker')
@patch('som.analysis.local_client.LocalClient')
async def test_reload_ruleset_worker_ok(mock_local_client):
    """Test reload_ruleset() works as expected for worker node with successful reload."""
    # Patch set_reload_ruleset_flag to be async and return a dict with 'success'
    from som.core.results import AffectedItemsSomResult

    async def async_set_reload_ruleset_flag(lc):
        return {'success': True}

    with patch('som.analysis.set_reload_ruleset_flag', side_effect=async_set_reload_ruleset_flag):
        result = await analysis.reload_ruleset()
        assert isinstance(result, analysis.AffectedItemsSomResult)
        assert result.total_affected_items == 1
        assert result.failed_items == {}


@pytest.mark.asyncio
@patch('som.analysis.node_type', 'worker')
@patch('som.analysis.local_client.LocalClient')
async def test_reload_ruleset_worker_nok(mock_local_client):
    """Test reload_ruleset() for worker node with error in reload."""
    from som.core.results import AffectedItemsSomResult
    from som.core.exception import SomError

    async def async_set_reload_ruleset_flag(lc):
        raise SomError(1914)

    with patch('som.analysis.set_reload_ruleset_flag', side_effect=async_set_reload_ruleset_flag):
        result = await analysis.reload_ruleset()
        assert isinstance(result, analysis.AffectedItemsSomResult)
        assert result.total_failed_items == 1
