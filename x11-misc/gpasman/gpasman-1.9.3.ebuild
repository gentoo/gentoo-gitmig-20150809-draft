# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gpasman/gpasman-1.9.3.ebuild,v 1.1 2006/02/07 16:46:32 nelchael Exp $

inherit eutils autotools

DESCRIPTION="Gpasman: GTK Password manager"
SRC_URI="http://gpasman.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://gpasman.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*"

src_unpack() {

	unpack "${A}"
	epatch "${FILESDIR}/${P}-gtk.patch"

	cd "${S}"
	intltoolize --copy --force
	eautoreconf

}

src_install() {

	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS README NEWS

}
