# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.29.ebuild,v 1.9 2001/09/08 08:39:48 chouser Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=media-libs/gdk-pixbuf-0.9.0
	 >=gnome-base/libglade-0.13
	 >=media-libs/gdk-pixbuf-0.9.0
	 >=gnome-base/libglade-0.13"


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

	./configure $myconf --host=${CHOST} --prefix=/opt/gnome \
		    --sysconfdir=/etc/opt/gnome --mandir=/opt/gnome/man

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dosed /opt/gnome/share/fonts/fontmap
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
