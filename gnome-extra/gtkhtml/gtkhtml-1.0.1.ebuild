# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-1.0.1.ebuild,v 1.1 2002/01/13 14:33:10 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gtkhtml"
SRC_URI="ftp://ftp.ximian.com/pub/source/evolution/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-extra/gal-0.19
	 >=gnome-base/control-center-1.4.0.1-r1
         >=gnome-base/libghttp-1.0.9-r1
         >=dev-libs/libunicode-0.4-r1
	 >=gnome-base/gconf-1.0.7-r2
         >=gnome-base/bonobo-1.0.18
	 >=gnome-base/gnome-print-0.34"

DEPEND="${RDEPEND}
	sys-devel/gettext
        >=dev-util/intltool-0.11"

src_compile() {

  	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --with-bonobo 					\
	            --with-gconf

	assert "Package configuration failed."

  	emake || die "Package building failed."
}

src_install() {

	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	# Fix the double entry in Control Center
	rm ${D}/usr/share/control-center/capplets/gtkhtml-properties.desktop

  	dodoc AUTHORS COPYING* ChangeLog README
  	dodoc NEWS TODO
}
