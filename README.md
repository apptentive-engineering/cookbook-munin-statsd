Description
===========

Installs and configures the munin-statsd bridge authored by Brian Staszewski (<brian.staszewski@tech-corps.com>).

Requirements
============

The `node['statsd']['host']` attribute must be set to the hostname or ip address of the statsd server.

## Platform

Tested on Amazon Linux.  Should be platform-neutral.

## Cookbooks

* perl

Attributes
==========

* `node['statsd']['host']` - hostname or ip address of the statsd server. 
* `node['statsd']['host']` - port of the statsd server.  Defaults to 8125

Recipes
=======

## default

Installs the `Munin::Node::Client` CPAN module, installs the munin-statsd script, and configures cron to run the script every minute.

License and Author
==================

- Author:: Michael Saffitz <mike@apptentive.com>

Copyright (c) 2013, Apptentive, Inc.
All rights reserved.

Released under the BSD 3-clause license.  See LICENSE for more information.
