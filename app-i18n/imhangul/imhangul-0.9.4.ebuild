# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/imhangul/imhangul-0.9.4.ebuild,v 1.2 2003/01/19 14:30:58 seo Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+-2.0 Hangul Input Modules"
SRC_URI="http://download.kldp.net/imhangul/${P}.tar.gz"
HOMEPAGE="http://imhangul.kldp.net"
KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.0.5"

src_compile() {
	./configure	\
		--prefix=/usr	\
		--sysconfdir=/etc || die "./configure failed"
	
	emake || die
}

src_install() {

	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		install || die
	
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS TODO
}
