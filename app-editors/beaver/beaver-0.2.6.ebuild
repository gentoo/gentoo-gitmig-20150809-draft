# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/beaver/beaver-0.2.6.ebuild,v 1.10 2006/08/20 22:42:14 malc Exp $

DESCRIPTION="An Early AdVanced EditoR"
SRC_URI="http://eturquin.free.fr/beaver/dloads/${P}.tar.gz"
HOMEPAGE="http://eturquin.free.fr/beaver/index.htm"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc x86"
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
