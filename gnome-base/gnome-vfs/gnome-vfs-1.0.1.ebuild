# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-1.0.1.ebuild,v 1.8 2001/08/31 22:04:27 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-vfs"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/gconf-1.0.0"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) 
	>=dev-util/xml-i18n-tools-0.8.4"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo-intl.diff || die
}

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} --prefix=/opt/gnome 		\
		    --sysconfdir=/etc/opt/gnome 			\
		    --mandir=/opt/gnome/man ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome 	\
	     mandir=${D}/opt/gnome/man install || die 

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}





