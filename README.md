puppet-node-status
==================

```text
USAGE
  puppet-node-status.rb --dashboard URL [ unresponsive failed pending changed unchanged unreported | --help ]
```

Quick start
-----------

```bash
# Something weird?
puppet-node-status.rb --dashboard "http://puppet/" unresponsive failed
```

I use this command in my crontab to send me a daily report about the Puppet healthiness.
