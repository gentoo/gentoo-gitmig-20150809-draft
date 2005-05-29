# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/beaver/beaver-0.2.6.ebuild,v 1.8 2005/05/29 18:48:51 yoswink Exp $

DESCRIPTION="An Early AdVanced EditoR"
SRC_URI="http://eturquin.free.fr/beaver/dloads/${P}.tar.gz"
HOMEPAGE="http://eturquin.free.fr/beaver/index.htm"

LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64 ~alpha"
SLOT="0"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	cd ${S}/src
	emake OPTI="${CFLAGS}" || die
}

src_install() {
	cd src
	make DESTDIR=${D}/usr \
	 MANDIR=/share/man \
	install || die
}
