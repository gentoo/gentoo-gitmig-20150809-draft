# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-1.4.0.4-r1.ebuild,v 1.4 2002/07/17 10:13:15 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The GNOME control-center"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL"
KEYWORDS="x86"

RDEPEND=">=gnome-base/gnome-vfs-1.0.2-r1
         >=media-libs/gdk-pixbuf-0.11.0-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) 
        >=dev-util/intltool-0.11"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	# Fix build agains gdk-pixbuf-0.12 and later
	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags`"
		
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    ${myconf} || die

	emake || die
}

src_install() {                               
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}






