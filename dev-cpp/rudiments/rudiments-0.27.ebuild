# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/rudiments/rudiments-0.27.ebuild,v 1.1 2005/01/01 04:49:47 matsuu Exp $

DESCRIPTION="C++ class library for daemons, clients and servers"
HOMEPAGE="http://rudiments.sourceforge.net/"
SRC_URI="mirror://sourceforge/rudiments/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall docdir=${D}/usr/share/doc/${PF}/html || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
