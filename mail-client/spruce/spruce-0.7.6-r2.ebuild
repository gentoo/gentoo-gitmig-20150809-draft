# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/spruce/spruce-0.7.6-r2.ebuild,v 1.4 2004/07/14 16:26:45 agriffis Exp $

IUSE="ssl nls gnome crypt"

DESCRIPTION="Gtk email client"
SRC_URI="ftp://spruce.sourceforge.net/pub/spruce/devel/${P}.tar.gz"
HOMEPAGE="http://spruce.sourceforge.net/"

DEPEND="=x11-libs/gtk+-1.2*
	gnome-base/libglade
	ssl? ( >=dev-libs/openssl-0.9.6 )
	crypt? ( app-crypt/gnupg )
	gnome? ( >=gnome-base/gnome-print-0.29-r1 )"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"

src_unpack() {
	unpack ${A}
	cd ${S}
	autoconf
}

src_compile() {
	local myconf

	use nls \
		|| myconf="--disable-nls"

	use ssl \
		&& echo "SSL does not work"
		#  myconf="${myconf} --with-ssl"

	use crypt \
		&& myconf="${myconf} --enable-pgp" \
		|| myconf="${myconf} --disable-pgp"

	use gnome \
		&& myconf="${myconf} --enable-gnome"

	CFLAGS="${CFLAGS} `gnome-config --cflags print gdk_pixbuf`"

	econf ${myconf} || die
	emake || die
}

src_install () {
	# Don't use DESTDIR, it doesn't follow the rules
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib \
	     mandir=${D}/usr/share/man \
	     infodir=${D}/usr/share/info \
	     install || die

	dodoc ChangeLog README* AUTHORS DESIGN NEWS THANKS TODO WISHLIST
}
