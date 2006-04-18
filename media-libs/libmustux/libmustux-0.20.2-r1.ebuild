# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmustux/libmustux-0.20.2-r1.ebuild,v 1.4 2006/04/18 17:57:13 flameeyes Exp $

inherit kde-functions autotools libtool multilib

DESCRIPTION="Protux - Library"
HOMEPAGE="http://www.nongnu.org/protux"
SRC_URI="http://vt.shuis.tudelft.nl/~remon/protux/stable/version-${PV}/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="|| ( ( x11-libs/libXt )
	virtual/x11 )
	=x11-libs/qt-3*
	media-libs/alsa-lib"

set-qtdir 3

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-qualifications.patches"

	eautoreconf
	elibtoolize
}

src_compile() {
	econf \
		--with-qt-lib-dir="${QTDIR}/$(get_libdir)" \
		|| die "Error: econf failed"
	emake || die "Error: emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYRIGHT ChangeLog NEWS README TODO
}
