# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/snmplib/snmplib-0.4.0.ebuild,v 1.3 2005/03/12 15:51:12 citizen428 Exp $

inherit ruby

IUSE=""
USE_RUBY="any"

MY_P="${P/snmplib/snmp}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="SNMP library implemented in pure Ruby"
HOMEPAGE="http://snmplib.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/2254/${MY_P}.tgz"

KEYWORDS="x86"
LICENSE="Ruby"
SLOT="0"

DEPEND="virtual/ruby"

src_install() {
	ruby setup.rb install --prefix=${D} || die
	dodoc README
	docinto examples
	dodoc ${S}/examples/*
}
