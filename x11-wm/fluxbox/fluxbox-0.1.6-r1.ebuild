# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.6-r1.ebuild,v 1.1 2002/02/14 22:06:56 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://download.sourceforge.net/fluxbox/fluxbox-${PV}.tar.gz"
HOMEPAGE="http://fluxbox.sf.net"

DEPEND="virtual/x11
	virtual/glibc
	kde? ( >=kde-base/kdebase-2.1 )
	nls? ( >=sys-devel/gettext-0.10.38 ) "
	
RDEPEND="$DEPEND"

src_compile() {
	local myconf
	use nls && myconf="$myconf --enable-nls" \
		|| myconf="$myconf --disable-nls"
	use kde && myconf="$myconf --enable-kde" \
		&& export KDEDIR=/usr/kde/2 \
		|| myconf="$myconf --disable-kde"
	 
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$myconf || die "./configure failed"
		
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
	
	exeinto /etc/X11/Sessions
	doexe $FILESDIR/fluxbox
}
