# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/tpb/tpb-0.5.1.ebuild,v 1.2 2004/04/06 04:07:48 vapier Exp $

inherit eutils

DESCRIPTION="Thinkpad button utility"
HOMEPAGE="http://savannah.nongnu.org/projects/tpb/"
SRC_URI="http://savannah.nongnu.org/download/tpb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X nls"

DEPEND="X? ( x11-libs/xosd )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-configure-fix.diff
}

src_compile() {
	econf `use_enable X xosd` `use_enable nls`

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
pkg_postinst() {
	einfo "tpb requires you to have nvram support compiled into"
	einfo "your kernel to function."
}
