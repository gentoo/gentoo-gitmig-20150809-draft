# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/snmplib/snmplib-1.0.2.ebuild,v 1.4 2009/04/25 17:40:29 armin76 Exp $

inherit ruby gems

IUSE=""
USE_RUBY="ruby18"

MY_P="${P/snmplib/snmp}"

DESCRIPTION="SNMP library implemented in pure Ruby"
HOMEPAGE="http://snmplib.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

KEYWORDS="amd64 ia64 ~ppc x86"
LICENSE="Ruby"
SLOT="0"
