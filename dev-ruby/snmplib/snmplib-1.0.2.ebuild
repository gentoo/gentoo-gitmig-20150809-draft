# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/snmplib/snmplib-1.0.2.ebuild,v 1.6 2010/05/22 15:58:26 flameeyes Exp $

inherit ruby gems

IUSE=""
USE_RUBY="ruby18"

MY_P="${P/snmplib/snmp}"

DESCRIPTION="SNMP library implemented in pure Ruby"
HOMEPAGE="http://snmplib.rubyforge.org/"
SRC_URI="mirror://rubygems/${MY_P}.gem"

KEYWORDS="amd64 ia64 ppc x86"
LICENSE="Ruby"
SLOT="0"
