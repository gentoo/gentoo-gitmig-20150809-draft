# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/adplug/adplug-1.5.ebuild,v 1.1 2004/10/01 14:29:31 spock Exp $

DESCRIPTION="A free, cross-platform, hardware independent AdLib sound player library"
HOMEPAGE="http://adplug.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""
DEPEND=">=dev-cpp/libbinio-1.2"

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
