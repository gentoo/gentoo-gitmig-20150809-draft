# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@bigfoot.com>
# Maintainer: Desktop Team <desktop@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/spruce/spruce-0.7.6-r2.ebuild,v 1.1 2001/11/10 00:03:58 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk email client"
SRC_URI="ftp://spruce.sourceforge.net/pub/spruce/devel/${P}.tar.gz"
HOMEPAGE="http://spruce.sourceforge.net/"

RDEPEND=">=x11-libs/gtk+-1.2.10-r4
         gnome-base/libglade
	 ssl? ( >=dev-libs/openssl-0.9.6 )
         gpg? ( app-crypt/gnupg )
         gnome? ( gnome-base/gnome-print-0.29-r1 )"

DEPEND="$RDEPEND
        nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	autoconf
}

src_compile() {
	local myopts

	if [ -z "`use nls`" ]; then
		myopts="--disable-nls"
	fi

	if [ "`use ssl`" ]; then
		echo "SSL does not work"
		#  myopts="$myopts --with-ssl"
	fi

	if [ "`use gpg`" ] ; then
		myopts="$myopts --enable-pgp"
	else
		myopts="$myopts --disable-pgp"
	fi

	if [ "`use gnome`" ] ; then
		myopts="$myopts --enable-gnome"
	fi

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
