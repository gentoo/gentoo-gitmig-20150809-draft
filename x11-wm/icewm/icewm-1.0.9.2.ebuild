# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/icewm/icewm-1.0.9.2.ebuild,v 1.2 2002/04/27 23:34:21 bangert Exp $

NV=1.0.9-2
S=${WORKDIR}/icewm-1.0.9
DESCRIPTION="Ice Window Manager"
SRC_URI="prdownloads.sourceforge.net/${PN}/${PN}-${NV}.tar.gz"
HOMEPAGE="www.icewm.org"

DEPEND="virtual/x11"

src_compile(){
	./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/X11/icewm || die
	emake || die
}
src_install(){
	make prefix=${D}/usr DOCDIR=${S}/dummy sysconfdir=${D}/etc/X11/icewm install || die
	dodoc BUGS CHANGES COPYING FAQ PLATFORMS README TODO VERSION
	docinto html
	dodoc doc/*.html
	docinto sgml
	dodoc doc/*.sgml
}


