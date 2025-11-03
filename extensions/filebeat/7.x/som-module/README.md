# Som Filebeat module

## Hosting

The Som Filebeat module is hosted at the following URLs

- Production:
  - https://packages.som.com/4.x/filebeat/
- Development:
  - https://packages-dev.som.com/pre-release/filebeat/
  - https://packages-dev.som.com/staging/filebeat/

The Som Filebeat module must follow the following nomenclature, where revision corresponds to X.Y values

- som-filebeat-{revision}.tar.gz

Currently, we host the following modules

|Module|Version|
|:--|:--|
|som-filebeat-0.1.tar.gz|From 3.9.x to 4.2.x included|
|som-filebeat-0.2.tar.gz|From 4.3.x to 4.6.x included|
|som-filebeat-0.3.tar.gz|4.7.x|
|som-filebeat-0.4.tar.gz|From 4.8.x to current|


## How-To update module tar.gz file

To add a new version of the module it is necessary to follow the following steps:

1. Clone the som/som repository
2. Check out the branch that adds a new version
3. Access the directory: **extensions/filebeat/7.x/som-module/**
4. Create a directory called: **som**

```
# mkdir som
```

5. Copy the resources to the **som** directory

```
# cp -r _meta som/
# cp -r alerts som/
# cp -r archives som/
# cp -r module.yml som/
```

6. Set **root user** and **root group** to all elements of the **som** directory (included)

```
# chown -R root:root som
```

7. Set all directories with **755** permissions

```
# chmod 755 som
# chmod 755 som/alerts
# chmod 755 som/alerts/config
# chmod 755 som/alerts/ingest
# chmod 755 som/archives
# chmod 755 som/archives/config
# chmod 755 som/archives/ingest
```

8. Set all yml/json files with **644** permissions

```
# chmod 644 som/module.yml
# chmod 644 som/_meta/config.yml
# chmod 644 som/_meta/docs.asciidoc
# chmod 644 som/_meta/fields.yml
# chmod 644 som/alerts/manifest.yml
# chmod 644 som/alerts/config/alerts.yml
# chmod 644 som/alerts/ingest/pipeline.json
# chmod 644 som/archives/manifest.yml
# chmod 644 som/archives/config/archives.yml
# chmod 644 som/archives/ingest/pipeline.json
```

9. Create **tar.gz** file

```
# tar -czvf som-filebeat-0.4.tar.gz som
```

10. Check the user, group, and permissions of the created file

```
# tree -pug som
[drwxr-xr-x root     root    ]  som
├── [drwxr-xr-x root     root    ]  alerts
│   ├── [drwxr-xr-x root     root    ]  config
│   │   └── [-rw-r--r-- root     root    ]  alerts.yml
│   ├── [drwxr-xr-x root     root    ]  ingest
│   │   └── [-rw-r--r-- root     root    ]  pipeline.json
│   └── [-rw-r--r-- root     root    ]  manifest.yml
├── [drwxr-xr-x root     root    ]  archives
│   ├── [drwxr-xr-x root     root    ]  config
│   │   └── [-rw-r--r-- root     root    ]  archives.yml
│   ├── [drwxr-xr-x root     root    ]  ingest
│   │   └── [-rw-r--r-- root     root    ]  pipeline.json
│   └── [-rw-r--r-- root     root    ]  manifest.yml
├── [drwxr-xr-x root     root    ]  _meta
│   ├── [-rw-r--r-- root     root    ]  config.yml
│   ├── [-rw-r--r-- root     root    ]  docs.asciidoc
│   └── [-rw-r--r-- root     root    ]  fields.yml
└── [-rw-r--r-- root     root    ]  module.yml
```

11. Upload file to development bucket
