# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-network/gnome-network-1.0.2-r1.ebuild,v 1.8 2004/01/16 21:38:25 foser Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="gnome-network"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

RDEPEND="=gnome-base/gnome-panel-1.4*
	=dev-util/guile-1.4*
	>=media-libs/gdk-pixbuf-0.11.0-r1"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.2
	nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Work around problems described in #27386
	epatch ${FILESDIR}/${P}-db_fix.patch

}

src_compile() {

	CFLAGS="${CFLAGS} `gnome-config --cflags gdk_pixbuf`"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--without-gnome-sync \
		--enable-static=no \
		--localstatedir=/var/lib || die "configure failure. please report to http://bugs.gentoo.org"

	emake || die "compile error"

}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}


