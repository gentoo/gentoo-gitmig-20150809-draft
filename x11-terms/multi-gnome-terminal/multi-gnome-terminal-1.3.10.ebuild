# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-terms/multi-gnome-terminal/multi-gnome-terminal-1.3.10.ebuild,v 1.1 2002/01/29 01:27:48 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Extended version of the Gnome Terminal."
SRC_URI="http://multignometerm.sourceforge.net/${P}.tar.bz2"
HOMEPAGE="http://multignometerm.sourceforge.net/"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=media-libs/gdk-pixbuf-0.11.0-r1
	>=gnome-base/libglade-0.17-r1
	>=app-text/scrollkeeper-0.2
	>=gnome-base/ORBit-0.5.10-r1
	nls? ( sys-devel/gettext )"


src_compile() {

	local myconf
	use nls     || myconf=--disable-nls
		
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info				\
		    --sysconfdir=/etc					\
		    ${myconf} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     sysconfdir=${D}/etc					\
	     install || die

	insinto /usr/share/pixmaps
	doins pixmaps/multignometerm.png

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README
}

pkg_postinst() {

	echo
	echo "********************************************************************"
	echo "*  Please note that the shortcut keys to create a new shell is not *"
	echo '*  "ctrl-l n" like stated in the docs, but "ctrl-F1 n".            *'
	echo "********************************************************************"
	echo
}

