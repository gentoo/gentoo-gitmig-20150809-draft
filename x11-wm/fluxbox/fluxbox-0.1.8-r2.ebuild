# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.8-r2.ebuild,v 1.1 2002/05/14 20:34:10 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz
		 http://fluxbox.sourceforge.net/download/patches/${P}-bugfix1.patch
		 http://fluxbox.sourceforge.net/download/patches/${P}-bugfix2.patch"
HOMEPAGE="http://fluxbox.sf.net"

DEPEND="virtual/x11"
	
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	patch -p1 < ${DISTDIR}/${P}-bugfix1.patch || die
	patch -p1 < ${DISTDIR}/${P}-bugfix2.patch || die
}

PROVIDE="virtual/blackbox"

src_compile() {
	local myconf
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use kde \
		&& myconf="${myconf} --enable-kde" \
		&& export KDEDIR=/usr/kde/2 \
		|| myconf="${myconf} --disable-kde"

	use gnome \
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome"
	 
	econf ${myconf} || die

	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/X11/fluxbox \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share \
		install || die

	dodoc ChangeLog AUTHORS COPYING INSTALL README TODO NEWS
	docinto data
	dodoc data/README*

	dodir /etc/X11/Sessions
	echo "/usr/bin/fluxbox" > ${D}/etc/X11/Sessions/fluxbox
	chmod +x ${D}/etc/X11/Sessions/fluxbox
}
