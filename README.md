# Som

[![Slack](https://img.shields.io/badge/slack-join-blue.svg)](https://som.com/community/join-us-on-slack/)
[![Email](https://img.shields.io/badge/email-join-blue.svg)](https://groups.google.com/forum/#!forum/som)
[![Documentation](https://img.shields.io/badge/docs-view-green.svg)](https://documentation.som.com)
[![Documentation](https://img.shields.io/badge/web-view-green.svg)](https://som.com)
[![Coverity](https://scan.coverity.com/projects/10992/badge.svg)](https://scan.coverity.com/projects/som-som)
[![Twitter](https://img.shields.io/twitter/follow/som?style=social)](https://twitter.com/som)
[![YouTube](https://img.shields.io/youtube/views/peTSzcAueEc?style=social)](https://www.youtube.com/watch?v=peTSzcAueEc)


Som is a free and open source platform used for threat prevention, detection, and response. It is capable of protecting workloads across on-premises, virtualized, containerized, and cloud-based environments.

Som solution consists of an endpoint security agent, deployed to the monitored systems, and a management server, which collects and analyzes data gathered by the agents. Besides, Som has been fully integrated with the Elastic Stack, providing a search engine and data visualization tool that allows users to navigate through their security alerts.

## Som capabilities

A brief presentation of some of the more common use cases of the Som solution.

**Intrusion detection**

Som agents scan the monitored systems looking for malware, rootkits and suspicious anomalies. They can detect hidden files, cloaked processes or unregistered network listeners, as well as inconsistencies in system call responses.

In addition to agent capabilities, the server component uses a signature-based approach to intrusion detection, using its regular expression engine to analyze collected log data and look for indicators of compromise.

**Log data analysis**

Som agents read operating system and application logs, and securely forward them to a central manager for rule-based analysis and storage. When no agent is deployed, the server can also receive data via syslog from network devices or applications.

The Som rules help make you aware of application or system errors, misconfigurations, attempted and/or successful malicious activities, policy violations and a variety of other security and operational issues.

**File integrity monitoring**

Som monitors the file system, identifying changes in content, permissions, ownership, and attributes of files that you need to keep an eye on. In addition, it natively identifies users and applications used to create or modify files.

File integrity monitoring capabilities can be used in combination with threat intelligence to identify threats or compromised hosts. In addition, several regulatory compliance standards, such as PCI DSS, require it.

**Vulnerability detection**

Som agents pull software inventory data and send this information to the server, where it is correlated with continuously updated CVE (Common Vulnerabilities and Exposure) databases, in order to identify well-known vulnerable software.

Automated vulnerability assessment helps you find the weak spots in your critical assets and take corrective action before attackers exploit them to sabotage your business or steal confidential data.

**Configuration assessment**

Som monitors system and application configuration settings to ensure they are compliant with your security policies, standards and/or hardening guides. Agents perform periodic scans to detect applications that are known to be vulnerable, unpatched, or insecurely configured.

Additionally, configuration checks can be customized, tailoring them to properly align with your organization. Alerts include recommendations for better configuration, references and mapping with regulatory compliance.

**Incident response**

Som provides out-of-the-box active responses to perform various countermeasures to address active threats, such as blocking access to a system from the threat source when certain criteria are met.

In addition, Som can be used to remotely run commands or system queries, identifying indicators of compromise (IOCs) and helping perform other live forensics or incident response tasks.

**Regulatory compliance**

Som provides some of the necessary security controls to become compliant with industry standards and regulations. These features, combined with its scalability and multi-platform support help organizations meet technical compliance requirements.

Som is widely used by payment processing companies and financial institutions to meet PCI DSS (Payment Card Industry Data Security Standard) requirements. Its web user interface provides reports and dashboards that can help with this and other regulations (e.g. GPG13 or GDPR).

**Cloud security**

Som helps monitoring cloud infrastructure at an API level, using integration modules that are able to pull security data from well known cloud providers, such as Amazon AWS, Azure or Google Cloud. In addition, Som provides rules to assess the configuration of your cloud environment, easily spotting weaknesses.

In addition, Som light-weight and multi-platform agents are commonly used to monitor cloud environments at the instance level.

**Containers security**

Som provides security visibility into your Docker hosts and containers, monitoring their behavior and detecting threats, vulnerabilities and anomalies. The Som agent has native integration with the Docker engine allowing users to monitor images, volumes, network settings, and running containers.

Som continuously collects and analyzes detailed runtime information. For example, alerting for containers running in privileged mode, vulnerable applications, a shell running in a container, changes to persistent volumes or images, and other possible threats.

## WUI

The Som WUI provides a powerful user interface for data visualization and analysis. This interface can also be used to manage Som configuration and to monitor its status.

**Modules overview**

![Modules overview](https://github.com/som/som-dashboard-plugins/raw/master/screenshots/app.png)

**Security events**

![Overview](https://github.com/som/som-dashboard-plugins/blob/master/screenshots/app2.png)

**Integrity monitoring**

![Overview](https://github.com/som/som-dashboard-plugins/blob/master/screenshots/app3.png)

**Vulnerability detection**

![Overview](https://github.com/som/som-dashboard-plugins/blob/master/screenshots/app4.png)

**Regulatory compliance**

![Overview](https://github.com/som/som-dashboard-plugins/blob/master/screenshots/app5.png)

**Agents overview**

![Overview](https://github.com/som/som-dashboard-plugins/blob/master/screenshots/app6.png)

**Agent summary**

![Overview](https://github.com/som/som-dashboard-plugins/blob/master/screenshots/app7.png)

## Orchestration

Here you can find all the automation tools maintained by the Som team.

* [Som AWS CloudFormation](https://github.com/som/som-cloudformation)

* [Docker containers](https://github.com/som/som-docker)

* [Som Ansible](https://github.com/som/som-ansible)

* [Som Chef](https://github.com/som/som-chef)

* [Som Puppet](https://github.com/som/som-puppet)

* [Som Kubernetes](https://github.com/som/som-kubernetes)

* [Som Bosh](https://github.com/som/som-bosh)

* [Som Salt](https://github.com/som/som-salt)

## Branches

* `main` branch contains the latest code, be aware of possible bugs on this branch.

## Software and libraries used

|Software|Version|Author|License|
|---|---|---|---|
|[bpftool](https://github.com/libbpf/bpftool)|7.5.0|libbpf|GNU Public License version 2|
|[bzip2](https://github.com/libarchive/bzip2)|1.0.8|Julian Seward|BSD License|
|[cJSON](https://github.com/DaveGamble/cJSON)|1.7.18|Dave Gamble|MIT License|
|[cpp-httplib](https://github.com/yhirose/cpp-httplib)|0.25.0|yhirose|MIT License|
|[cPython](https://github.com/python/cpython)|3.10.18|Guido van Rossum|Python Software Foundation License version 2|
|[cURL](https://github.com/curl/curl)|8.11.1|Daniel Stenberg|MIT License|
|[dbus](https://gitlab.freedesktop.org/dbus/dbus)|1.14.10|freedesktop.org|GNU Public License version 2|
|[Flatbuffers](https://github.com/google/flatbuffers/)|23.5.26|Google Inc.|Apache 2.0 License|
|[Google Benchmark](https://github.com/google/benchmark)|1.6.1|Google Inc.|Apache 2.0 License||
|[GoogleTest](https://github.com/google/googletest)|1.11.0|Google Inc.|3-Clause "New" BSD License|
|[jemalloc](https://github.com/jemalloc/jemalloc)|5.2.1|Jason Evans|2-Clause "Simplified" BSD License|
|[libarchive](https://github.com/libarchive/libarchive)|3.7.2|Tim Kientzle|3-Clause "New" BSD License|
|[libbpf](https://github.com/libbpf/libbpf)|1.5.0|libbpf|GNU Lesser General Public License version 2.1|
|[libdb](https://github.com/yasuhirokimura/db18)|18.1.40|Oracle Corporation|Affero GPL v3|
|[libffi](https://github.com/libffi/libffi)|3.2.1|Anthony Green|MIT License|
|[libpcre2](https://github.com/PCRE2Project/pcre2)|10.42.0|Philip Hazel|BSD License|
|[libplist](https://github.com/libimobiledevice/libplist)|2.2.0|Aaron Burghardt et al.|GNU Lesser General Public License version 2.1|
|[libYAML](https://github.com/yaml/libyaml)|0.1.7|Kirill Simonov|MIT License|
|[liblzma](https://github.com/tukaani-project/xz)|5.4.2|Lasse Collin, Jia Tan et al.|GNU Public License version 3|
|[Linux Audit userspace](https://github.com/linux-audit/audit-userspace)|2.8.4|Rik Faith|GNU Lesser General Public License|
|[Lua](https://github.com/lua/lua)|5.3.6|PUC-Rio|MIT License|
|[msgpack](https://github.com/msgpack/msgpack-c)|3.1.1|Sadayuki Furuhashi|Boost Software License version 1.0|
|[nlohmann](https://github.com/nlohmann/json)|3.11.2|Niels Lohmann|MIT License|
|[OpenSSL](https://github.com/openssl/openssl)|3.5.1|OpenSSL Software Foundation|Apache 2.0 License|
|[pacman](https://gitlab.archlinux.org/pacman/pacman)|5.2.2|Judd Vinet|GNU Public License version 2|
|[popt](https://github.com/rpm-software-management/popt)|1.16|Jeff Johnson & Erik Troan|MIT License|
|[procps](https://gitlab.com/procps-ng/procps)|2.8.3|Brian Edmonds et al.|GNU Lesser General Public License|
|[RocksDB](https://github.com/facebook/rocksdb/)|8.3.2|Facebook Inc.|Apache 2.0 License|
|[rpm](https://github.com/rpm-software-management/rpm)|4.20.1|Marc Ewing & Erik Troan|GNU Public License version 2|
|[simdjson](https://github.com/simdjson/simdjson)|3.13.0|Daniel Lemire|Apache License 2.0|
|[sqlite](https://github.com/sqlite/sqlite)|3.50.4|D. Richard Hipp|Public Domain (no restrictions)|
|[zlib](https://github.com/madler/zlib)|1.3.1|Jean-loup Gailly & Mark Adler|zlib/libpng License|

* [PyPi packages](framework/requirements.txt)

## Documentation

* [Full documentation](http://documentation.som.com)
* [Som installation guide](https://documentation.som.com/current/installation-guide/index.html)

## Get involved

Become part of the [Som's community](https://som.com/community/) to learn from other users, participate in discussions, talk to our developers and contribute to the project.

If you want to contribute to our project please don’t hesitate to make pull-requests, submit issues or send commits, we will review all your questions.

You can also join our [Slack community channel](https://som.com/community/join-us-on-slack/) and [mailing list](https://groups.google.com/d/forum/som) by sending an email to [som+subscribe@googlegroups.com](mailto:som+subscribe@googlegroups.com), to ask questions and participate in discussions.

Stay up to date on news, releases, engineering articles and more.

* [Som website](http://som.com)
* [Linkedin](https://www.linkedin.com/company/som)
* [YouTube](https://www.youtube.com/c/somsecurity)
* [Twitter](https://twitter.com/som)
* [Som blog](https://som.com/blog/)
* [Slack announcements channel](https://som.com/community/join-us-on-slack/)

## Authors

Som Copyright (C) 2015-2023 Som Inc. (License GPLv2)

Based on the OSSEC project started by Daniel Cid.
