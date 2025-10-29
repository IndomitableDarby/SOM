# API Reference

The Inventory Harvester module indexes FIM and Inventory data into dedicated indices within the som-indexer (OpenSearch). So the information is retrieved by using the Opensearch API (ref: https://opensearch.org/docs/latest/api-reference/).

For a quick reference, the table below lists the component and its specific query.

| Component                    | Query                                                    |
|------------------------------|----------------------------------------------------------|
| Inventory OS                 | GET /som-states-inventory-system-*/_search             |
| Inventory Packages           | GET /som-states-inventory-packages-*/_search           |
| Inventory Processes          | GET /som-states-inventory-processes-*/_search          |
| Inventory Ports              | GET /som-states-inventory-ports-*/_search              |
| Inventory Hardware           | GET /som-states-inventory-hardware-*/_search           |
| Inventory Hotfixes           | GET /som-states-inventory-hotfixes-*/_search           |
| Inventory Network Addresses  | GET /som-states-inventory-networks-*/_search           |
| Inventory Network Protocols  | GET /som-states-inventory-protocols-*/_search          |
| Inventory Network Interfaces | GET /som-states-inventory-interfaces-*/_search         |
| Inventory Users              | GET /som-states-inventory-users-*/_search              |
| Inventory Groups             | GET /som-states-inventory-groups-*/_search             |
| Inventory Browser Extensions | GET /som-states-inventory-browser-extensions-*/_search |
| Inventory Services           | GET /som-states-inventory-services-*/_search           |

Refer to [Description](description.md) to visualize the retrieved document format for each request.
