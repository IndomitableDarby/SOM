<!---
Copyright (C) 2015, Som Inc.
Created by Som, Inc. <info@som.com>.
This program is free software; you can redistribute it and/or modify it under the terms of GPLv2
-->

# Metrics

## Index

- [Metrics](#metrics)
  - [Index](#index)
  - [Purpose](#purpose)
  - [Sequence diagram](#sequence-diagram)

## Purpose

Som includes some metrics to understand the behavior of its components, which allow to investigate errors and detect problems with some configurations. This feature has multiple actors: `som-remoted` for agent interaction messages, `som-analysisd` for processed events.

## Sequence diagram

The sequence diagram shows the basic flow of metric counters. These are the main flows:

1. Messages received by `som-remoted` from agents.
2. Messages that `som-remoted` sends to agents.
3. Events received by `som-analysisd`.
4. Events processed by `som-analysisd`.
