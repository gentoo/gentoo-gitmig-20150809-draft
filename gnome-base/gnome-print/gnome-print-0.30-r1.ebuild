# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.30-r1.ebuild,v 1.1 2001/10/16 23:43:03 hallski Exp $


S=${WORKDIR}/${P}
DESCRIPTION="gnome-print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	 >=gnome-base/libglade-0.17-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) 
        sys-devel/perl
        >=app-text/ghostscript-6.50-r2"

src_unpack() {
	unpack ${P}.tar.gz
	
	cd ${S}
	# add missing DESTDIR to font installation
	sed -e 's:install $(datadir):install $(DESTDIR)$(datadir):' \
		installer/Makefile.in > installer/Makefile.in.new
	mv installer/Makefile.in.new installer/Makefile.in
}

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc 					\
		    --localstatedir=/var/lib				\
		    $myconf || die

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dosed /usr/share/fonts/fontmap
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
