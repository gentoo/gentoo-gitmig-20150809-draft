# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/led/led-1.79.4.ebuild,v 1.1 2004/12/08 11:28:06 robbat2 Exp $

inherit eutils
DESCRIPTION="led is a general purpose LDAP editor"
HOMEPAGE="http://led.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-perl/perl-ldap
	dev-perl/URI
	dev-perl/Digest-MD5
	dev-perl/Authen-SASL"

src_compile() {
	# non-standard configure system!
	perl Configure --prefix=/usr --generic --rfc2307 --shadow --local --iplanet
	# parallel make bad
	emake -j1
}

src_install() {
	dobin ldapcat
	newbin led.pl led # this is weird I know, read the generated Makefile to see why...
	dodoc INSTALL README README.ldapcat TODO
}
