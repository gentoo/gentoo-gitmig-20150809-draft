# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/testunit/testunit-0.1.5.ebuild,v 1.8 2004/07/14 22:18:10 agriffis Exp $

inherit ruby

DESCRIPTION="unit testing framework for the Ruby language"
HOMEPAGE="http://testunit.talbott.ws/"
SRC_URI="http://testunit.talbott.ws/packages/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"
IUSE=""

# testunit is included in ruby distribution from 1.8
RUBY="/usr/bin/ruby16"
DEPEND="=dev-lang/ruby-1.6*"
