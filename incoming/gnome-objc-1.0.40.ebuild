# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Andreas Voegele <voegelas@users.sourceforge.net>
# /home/cvsroot/gentoo-x86/skel.build,v 1.9 2001/10/21 16:17:12 agriffis Exp

S=${WORKDIR}/${P}
DESCRIPTION="Objective C bindings for GTK+ and GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-objc/gnome-objc-1.0.40.tar.gz"
HOMEPAGE="http://www.gnome.org/"
DEPEND="virtual/glibc
        >=x11-libs/gtk+-1.2.10-r4
        nls? ( >=sys-devel/gettext-0.10.39-r1 )
        gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ -z "`use gnome`" ]; then
		mv Makefile.in Makefile.in.orig
		sed -e 's/\(built_SUBDIRS = obgtk\) obgnome/\1/' \
		    Makefile.in.orig >Makefile.in
	fi
}

src_compile() {
	local myconf
	use gnome || myconf="--without-gnome"
	#Disabling NLS doesn't work (at least if gettext is installed;
	#don't know what happens if gettext is not available)
	#use nls || myconf="${myconf} --disable-nls"
	./configure --host=${CHOST} \
	            --prefix=/usr \
	            --mandir=/usr/share/man \
	            --infodir=/usr/share/info \
	            ${myconf} || die
	mv obgnome-config obgnome-config.orig
	sed -e 's:$(includedir):/usr/include:' \
	    obgnome-config.orig >obgnome-config
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING* obgtk/README
	docinto examples
	dodoc obgtk/obgtk-test.m obgnome/obgnome-hello*
}

# Local Variables:
# mode:sh
# tab-width:4
# End:
# vim: ai et sw=4 ts=4
