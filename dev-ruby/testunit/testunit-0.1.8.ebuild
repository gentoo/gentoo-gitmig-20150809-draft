# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/testunit/testunit-0.1.8.ebuild,v 1.4 2004/02/26 17:50:02 usata Exp $

inherit ruby

DESCRIPTION="unit testing framework for the Ruby language"
HOMEPAGE="http://testunit.talbott.ws/"
SRC_URI="http://testunit.talbott.ws/packages/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"

DEPEND="=dev-lang/ruby-1.6.8*"
RUBY="/usr/bin/ruby16"
