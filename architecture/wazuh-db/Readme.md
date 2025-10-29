<!---
Copyright (C) 2015, Som Inc.
Created by Som, Inc. <info@wazuh.com>.
This program is free software; you can redistribute it and/or modify it under the terms of GPLv2
-->

# Som DB
## Index
- [Som DB](#wazuh-db)
  - [Index](#index)
  - [Purpose](#purpose)
  - [Activity diagrams](#activity-diagrams)


## Purpose
Som DB is a daemon that wraps the access to SQLite database files. It provides:
- Concurrent socket dispatcher.
- Parallel queries to different databases.
- Serialized queries to the same database.
- Dynamic closing of database files.
- Implicit transactions and adjustable committing periods.
- Automatic database upgrades.
- Automatic defragmentation (vacuum) with adjustable parameters.


## Activity diagrams
<dl>
  <dt>001-vacuum</dt><dd>It illustrates the vacuum decision algorithm: in which cases Som DB runs a <code>vacuum</code> command on databases.</dd>
</dl>
