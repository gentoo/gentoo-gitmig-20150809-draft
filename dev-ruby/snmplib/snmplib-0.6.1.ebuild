# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/snmplib/snmplib-0.6.1.ebuild,v 1.1 2006/02/18 15:50:03 citizen428 Exp $

inherit ruby gems

IUSE=""
USE_RUBY="any"

MY_P="${P/snmplib/snmp}"

DESCRIPTION="SNMP library implemented in pure Ruby"
HOMEPAGE="http://snmplib.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

KEYWORDS="~ppc ~x86"
LICENSE="Ruby"
SLOT="0"

DEPEND="virtual/ruby"

