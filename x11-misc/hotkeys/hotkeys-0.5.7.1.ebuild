# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/hotkeys/hotkeys-0.5.7.1.ebuild,v 1.7 2004/04/09 13:09:20 lanius Exp $

DESCRIPTION="Make use of extra buttons on newer keyboards."
SRC_URI="http://ypwong.org/hotkeys/${PV}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://ypwong.org/hotkeys/"
IUSE="gtk"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/x11
	>=dev-libs/libxml2-2.2.8
	=sys-libs/db-3.2*
	!>=sys-libs/db-4*
	>=x11-libs/xosd-1.0.0
	gtk? ( >=x11-libs/gtk+-2.0.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

	local myconf="--with-xosd"

	use gtk \
		&& myconf="${myconf} --with-gtk"

	econf ${myconf} || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING README TODO
}
