# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.32.ebuild,v 1.2 2001/11/15 00:41:01 achim Exp $


S=${WORKDIR}/${P}
DESCRIPTION="gnome-print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	 >=gnome-base/libglade-0.17-r1
	 >=media-libs/freetype-2.0.5"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) 
	tex? ( app-text/tetex )
        sys-devel/perl
        >=app-text/ghostscript-6.50-r2"

src_unpack() {
	unpack ${P}.tar.gz
	
	cd ${S}
	# add missing DESTDIR to font installation
	sed 's:all \($(datadir).*\)\($(sysconfdir)\):all $(DESTDIR)\1$(DESTDIR)\2:'\
		installer/Makefile.in > installer/Makefile.in.new
	mv installer/Makefile.in.new installer/Makefile.in
	# add --clean to gnome-font-install options so that currently-installed
	# fontmaps will be ignored and new complete ones will be built
	sed "s:'--dynamic',:& '--clean',:" \
		run-gnome-font-install > run-gnome-font-install.new
	mv run-gnome-font-install.new run-gnome-font-install
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
	make DESTDIR=${D} install || die

	dosed /etc/gnome/fonts/*
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
