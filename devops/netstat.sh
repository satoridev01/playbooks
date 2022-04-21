install:
  - [netstat -tulpen > netstat.orig]
  - [ls]
  - [netstat -tulpen > netstat.new]

netstat:
  assertStdout: False
  execute:
    - [diff netstat.orig netstat.new]
