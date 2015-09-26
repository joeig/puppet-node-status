puppet-node-status
==================

Displays a summary of the nodes' status provided by Puppet Dashboard.

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
