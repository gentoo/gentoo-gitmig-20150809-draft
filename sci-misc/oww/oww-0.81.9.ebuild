# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/oww/oww-0.81.9.ebuild,v 1.1 2006/11/30 00:02:40 markusle Exp $

DESCRIPTION="A one-wire weather station for Dallas Semiconductor"
HOMEPAGE="http://oww.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=x11-libs/gtk+-2.6
	net-misc/curl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s:doc/oww:doc/${P}/:" -i Makefile.in || \
		die "Failed to fix doc install path"
}

src_compile() {
	econf --enable-interactive || die "Failed during configure"
	emake || die "Failed during make."
}

src_install () {
	make DESTDIR="${D}" install || die "Failed during install."
}
