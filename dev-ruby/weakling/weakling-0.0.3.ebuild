# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/weakling/weakling-0.0.3.ebuild,v 1.1 2011/04/30 15:13:34 graaff Exp $

EAPI=2

# This package is specifically for JRuby.
USE_RUBY="jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="HISTORY.txt README.txt"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="weakling: a collection of weakref utilities for Ruby"
HOMEPAGE="http://github.com/headius/weakling"
LICENSE="Apache-2.0"  # Not distributed in gem but in github repository

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

# We install the pre-compiled .jar file instead of compiling it
# ourselves because the rake-compiler setup does not work with Gentoo's
# java environment here.
