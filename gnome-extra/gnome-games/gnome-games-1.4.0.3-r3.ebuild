# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Reviewed by Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-1.4.0.3-r3.ebuild,v 1.16 2004/07/14 15:32:15 agriffis Exp $

IUSE="nls"

DESCRIPTION="gnome-utils"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
	=dev-util/guile-1.4*
	>=media-libs/gdk-pixbuf-0.11.0-r1"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.2
	nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}

#	# Fix build error with guile >= 1.5
#	cd ${S}/aisleriot
#	patch < ${FILESDIR}/guile-1.5-gentoo.diff || die
#	cd ${S}
}

src_compile() {
	local myconf

	if ! use nls ; then
		myconf="--disable-nls"
	fi

	CFLAGS="${CFLAGS} `gnome-config --cflags gdk_pixbuf`"

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --with-ncurses $myconf || die

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}
