# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/signify/signify-1.14.1.ebuild,v 1.1 2005/01/13 20:00:07 tove Exp $

inherit versionator

MY_PV=$(replace_version_separator 2 '-' )
S=${WORKDIR}/${PN}

DESCRIPTION="A (semi-)random e-mail signature rotator"
SRC_URI="mirror://debian/pool/main/s/${PN}/${PN}_${MY_PV}.tar.gz"
HOMEPAGE="http://signify.sf.net/"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's/head -1/head -n1/' Makefile
}
src_compile() {
	echo "Perl script!  Woohoo!  No need to compile!"
}

src_install() {
	make PREFIX=${D}/usr/ MANDIR=${D}/usr/share/man install || die
	dodoc COPYING README
	docinto examples
	dodoc examples/{Columned,Complex,Simple,SimpleOrColumned}
}
