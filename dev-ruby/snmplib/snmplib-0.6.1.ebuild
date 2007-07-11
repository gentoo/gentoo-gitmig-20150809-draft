# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/snmplib/snmplib-0.6.1.ebuild,v 1.8 2007/07/11 05:23:08 mr_bones_ Exp $

inherit ruby gems

IUSE=""
USE_RUBY="any"

MY_P="${P/snmplib/snmp}"

DESCRIPTION="SNMP library implemented in pure Ruby"
HOMEPAGE="http://snmplib.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

KEYWORDS="amd64 ia64 ppc x86"
LICENSE="Ruby"
SLOT="0"

DEPEND="virtual/ruby"
