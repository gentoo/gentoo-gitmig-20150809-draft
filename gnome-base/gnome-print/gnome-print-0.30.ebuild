# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.30.ebuild,v 1.1 2001/10/06 10:06:50 hallski Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	 >=gnome-base/libglade-0.17-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) 
        sys-devel/perl
        >=app-text/ghostscript-6.50-r2"

src_compile() {
	# add missing DESTDIR to font installation
	sed -e 's:install $(datadir):install $(DESTDIR)$(datadir):' \
		installer/Makefile.in > installer/Makefile.in.new
	mv installer/Makefile.in.new installer/Makefile.in
	
	# apply use settings
	local myconf
	[ -z "`use nls`" ] && myconf="--disable-nls"

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc 					\
		    $myconf || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dosed /usr/share/fonts/fontmap
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
