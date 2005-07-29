# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sjog/sjog-0.6-r1.ebuild,v 1.1 2005/07/29 22:58:07 vanquirius Exp $

inherit eutils

DESCRIPTION="sjog - tool for the Sony Vaio jogdial"
HOMEPAGE="http://sjog.sourceforge.net/"
SRC_URI="mirror://sourceforge/sjog/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	=dev-libs/glib-1.2*"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_install() {
	make DESTDIR=${D} install
}

pkg_postinst() {
	einfo "Please ensure that the module sonypi is probed with the option"
	einfo "useinput=0. For example:"
	einfo
	einfo "# modprobe sonypi useinput=0"
	einfo
	einfo "Otherwise, you will get multiple events being called."
}
