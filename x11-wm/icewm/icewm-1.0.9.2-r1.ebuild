# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/icewm/icewm-1.0.9.2-r1.ebuild,v 1.1 2002/02/11 04:43:00 drobbins Exp $

NV=1.0.9-2
S=${WORKDIR}/icewm-1.0.9
DESCRIPTION="Ice Window Manager"
SRC_URI="prdownloads.sourceforge.net/${PN}/${PN}-${NV}.tar.gz"
HOMEPAGE="www.icewm.org"

DEPEND="virtual/x11 media-libs/imlib"

src_compile(){
	./configure --with-imlib --host=${CHOST} --prefix=/usr --sysconfdir=/etc || die
	emake || die
}
src_install(){
	make prefix=${D}/usr DOCDIR=${S}/dummy sysconfdir=${D}/etc install || die
	dodoc BUGS CHANGES COPYING FAQ PLATFORMS README TODO VERSION
	docinto html
	dodoc doc/*.html
	docinto sgml
	dodoc doc/*.sgml
}


