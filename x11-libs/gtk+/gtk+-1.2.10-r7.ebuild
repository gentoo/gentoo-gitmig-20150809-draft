# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-1.2.10-r7.ebuild,v 1.1 2002/03/24 02:52:51 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The GIMP Toolkit"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${P}.tar.gz
         ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz
         http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz"

DEPEND="virtual/glibc virtual/x11
        >=dev-libs/glib-1.2.10
		nls? ( sys-devel/gettext
		dev-util/intltool )"

src_unpack() {

	unpack ${A}
	
	cd ${S}
	patch -p0 < ${FILESDIR}/gtk-1.2.10.patch || die

	cd ..
	patch -p0 < ${FILESDIR}/${PV}/gtk+-filesel-navigation-buttons.patch || die
	patch -p0 < ${FILESDIR}/${PV}/gtk+-filesel-move-fileops.patch || die
	patch -p0 < ${FILESDIR}/${PV}/gtk+-filesel-save-dir.patch || die
	patch -p0 < ${FILESDIR}/${PV}/gtk+-filesel-dirchanged-fix.patch || die
	
}

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	if [ "${DEBUG}" ]
	then
		myconf="${myconf} --enable-debug=yes"
	else
		myconf="${myconf} --enable-debug=no"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr 					\
		    --mandir=/usr/share/man 				\
		    --sysconfdir=/etc/X11 				\
		    --with-xinput=xfree 				\
		    --with-x 						\
		    ${myconf} || die

	emake || die
}

src_install() {

	make install DESTDIR=${D} || die

	preplib /usr

	dodoc AUTHORS COPYING ChangeLog* HACKING
	dodoc NEWS* README* TODO
	docinto docs
	cd docs
	dodoc *.txt *.gif text/*
	dohtml -r html

	#install nice, clean-looking gtk+ style
	insinto /usr/share/themes/Gentoo/gtk
	doins ${FILESDIR}/gtkrc
}

pkg_postinst() {

	echo
	echo "**********************************************************************"
	echo "* Older versions added /etc/X11/gtk/gtkrc which changed settings for *"
	echo "* all themes it seems.  Please remove it manually as it will not due *"
	echo "* to /env protection.                                                *"
	echo "*                                                                    *"
	echo "* NB:  The old gtkrc is available through the new Gentoo gtk theme.  *"
	echo "**********************************************************************"
	echo
}
