install:
  - [netstat -tulpen > netstat-tulpen.orig]
  - [netstat -atupen > netstat-atupen.orig]
  - [ls]
  - [netstat -tulpen > netstat-tulpen.new]
  - [netstat -atupen > netstat-atupen.new]

netstat:
  assertStdout: False
  execute:
    - [diff netstat-tulpen.orig netstat-tulpen.new]
    - [diff netstat-atupen.orig netstat-atupen.new]
