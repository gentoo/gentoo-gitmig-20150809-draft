# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-1.2.3-r2.ebuild,v 1.16 2004/07/14 15:33:02 agriffis Exp $

IUSE="nls alsa"


DESCRIPTION="gnome-media"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.2
	nls? ( sys-devel/gettext )"


src_compile() {
	local myconf

	if ! use nls ; then
		myconf="--disable-nls"
	fi

	if use alsa ; then
		myconf="${myconf} --enable-alsa=yes"
	else
		myconf="${myconf} --enable-alsa=no"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --with-ncurses				\
			${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}
