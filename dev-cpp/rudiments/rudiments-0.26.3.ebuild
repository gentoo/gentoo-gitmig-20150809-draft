# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/rudiments/rudiments-0.26.3.ebuild,v 1.4 2006/02/20 07:33:19 halcy0n Exp $

DESCRIPTION="C++ class library for daemons, clients and servers"
HOMEPAGE="http://rudiments.sourceforge.net/"
SRC_URI="mirror://sourceforge/rudiments/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall docdir=${D}/usr/share/doc/${PF}/html || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
