# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authour: Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-0.13.0.ebuild,v 1.1 2001/09/26 23:46:39 azarah Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtkhtml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="sys-devel/gettext
	>=gnome-base/gal-0.6
	>=gnome-base/control-center-1.2.4
        >=gnome-base/libghttp-1.0.9
        >=gnome-base/libunicode-0.4
	>=gnome-base/bonobo-1.0.4
	>=gnome-base/gconf-1.0.1
        >=dev-util/xml-i18n-tools-0.8.4"

RDEPEND=">=gnome-base/gal-0.5
	 >=gnome-base/control-center-1.2.4
         >=gnome-base/libghttp-1.0.9
         >=gnome-base/libunicode-0.4
	 >=gnome-base/gconf-1.0.1
         >=gnome-base/bonobo-1.0.4"


src_compile() {

  	./configure --host=${CHOST} --prefix=/opt/gnome 	\
		 --sysconfdir=/etc/opt/gnome --with-bonobo 	\
	         --with-gconf

	assert "Package configuration failed."

  	emake || die "Package building failed."
}

src_install() {
	make DESTDIR=${D} install || die "Package installation failed."

	# Fix the double entry in Control Center
	rm ${D}/opt/gnome/share/control-center/capplets/gtkhtml-properties.desktop

  	dodoc AUTHORS COPYING* ChangeLog README
  	dodoc NEWS TODO
}













