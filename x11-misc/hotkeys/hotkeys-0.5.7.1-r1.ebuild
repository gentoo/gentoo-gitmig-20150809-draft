# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/hotkeys/hotkeys-0.5.7.1-r1.ebuild,v 1.1 2003/08/15 11:25:28 lanius Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Make use of extra buttons on newer keyboards."
SRC_URI="http://ypwong.org/hotkeys/${PV}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://ypwong.org/hotkeys/"
IUSE="X gtk2 xosd"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

DEPEND="X? ( virtual/x11 )
	>=dev-libs/libxml2-2.2.8
	=sys-libs/db-3.2*
	!>=sys-libs/db-4*
	xosd? ( >=x11-libs/xosd-1.0.0 )
	gtk2? ( >=x11-libs/gtk+-2.0.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

	use X \
		&& myconf="${myconf} --with-X" \
		|| myconf="${myconf} --without-X"

	use xosd \
		&& myconf="${myconf} --with-xosd" \
		|| myconf="${myconf} --without-xosd"

	use gtk2 \
		&& myconf="${myconf} --with-gtk" \
		|| myconf="${myconf} --without-gtk"

	econf ${myconf} || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING README TODO
}
