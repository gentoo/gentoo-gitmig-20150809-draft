# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.7-r3.ebuild,v 1.8 2002/04/30 04:16:29 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://download.sourceforge.net/fluxbox/fluxbox-${PV}.tar.gz http://fluxbox.sourceforge.net/download/patches/${P}-bugfix1.patch"
HOMEPAGE="http://fluxbox.sf.net"

DEPEND="virtual/x11"
	
RDEPEND="${DEPEND}
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-bugfix1.patch || die
}

PROVIDE="virtual/blackbox"

src_compile() {
	local myconf
	use nls	\
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use kde 	\
		&& myconf="${myconf} --enable-kde" \
		&& export KDEDIR=/usr/kde/2 \
		|| myconf="${myconf} --disable-kde"

	use gnome 	\
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome"
	 
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$myconf || die

	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/X11/fluxbox \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc ChangeLog AUTHORS COPYING INSTALL README TODO NEWS
	docinto data
	dodoc data/README*

	dodir /etc/X11/Sessions
	echo "/usr/bin/fluxbox" > ${D}/etc/X11/Sessions/fluxbox
	chmod +x ${D}/etc/X11/Sessions/fluxbox
}
