# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/snmplib/snmplib-0.5.1.ebuild,v 1.3 2007/01/21 08:22:04 pclouds Exp $

RUBY_BUG_145222=yes
inherit ruby

IUSE="examples"
USE_RUBY="any"

MY_P="${P/snmplib/snmp}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="SNMP library implemented in pure Ruby"
HOMEPAGE="http://snmplib.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/5337/${MY_P}.tgz"

KEYWORDS="~ppc x86"
LICENSE="Ruby"
SLOT="0"

DEPEND="virtual/ruby"

src_install() {
	ruby setup.rb install --prefix=${D} || die
	dodoc README
	docinto examples
	dodoc ${S}/examples/*
}
