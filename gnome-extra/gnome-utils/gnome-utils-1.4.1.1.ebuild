# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-1.4.1.1.ebuild,v 1.1 2001/10/25 16:50:24 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gnome-utils"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
	 >=gnome-base/libgtop-1.0.12-r1
	 >=gnome-base/libglade-0.17-r1
         >=sys-apps/e2fsprogs-1.19-r2"

DEPEND="${RDEPEND}
        >=dev-util/guile-1.4
        >=sys-apps/shadow-20000000
        nls? ( sys-devel/gettext )"


src_unpack() {
	unpack ${A}
	
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-compile.patch
	automake
	autoconf
}

src_compile() {                           
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	CFLAGS="${CFLAGS} `gnome-config --cflags libglade`"

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --with-ncurses 					\
		    --with-messages=/var/log/syslog.d/current 		\
		    --localstatedir=/var/lib				\
		    --sysconfdir=/etc $myconf || die
	
	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/usr					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}
