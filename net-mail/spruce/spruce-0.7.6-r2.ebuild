# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@bigfoot.com>
# Maintainer: Desktop Team <desktop@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/spruce/spruce-0.7.6-r2.ebuild,v 1.3 2002/04/16 01:00:28 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk email client"
SRC_URI="ftp://spruce.sourceforge.net/pub/spruce/devel/${P}.tar.gz"
HOMEPAGE="http://spruce.sourceforge.net/"

RDEPEND=">=x11-libs/gtk+-1.2.10-r4
	gnome-base/libglade
	ssl? ( >=dev-libs/openssl-0.9.6 )
	crypt? ( app-crypt/gnupg )
	gnome? ( >=gnome-base/gnome-print-0.29-r1 )"

DEPEND="$RDEPEND
        nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	autoconf
}

src_compile() {
	local myopts

	use nls \
		|| myopts="--disable-nls"

	use ssl \
		&& echo "SSL does not work"
		#  myopts="$myopts --with-ssl"

	use crypt \
		&& myopts="$myopts --enable-pgp" \
		|| myopts="$myopts --disable-pgp"

	use gnome \
		&& myopts="$myopts --enable-gnome"

	CFLAGS="${CFLAGS} `gnome-config --cflags print gdk_pixbuf`"

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info				\
	 	    ${myopts} || die

	emake || die
}

src_install () {
	# Don't use DESTDIR, it doesn't follow the rules
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc ChangeLog README README.firewall INSTALL
}
