# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/beaver/beaver-0.2.6.ebuild,v 1.1 2003/03/10 09:21:53 aliz Exp $

S=${WORKDIR}/${P}

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DESCRIPTION="An Early AdVanced EditoR"
SRC_URI="http://eturquin.free.fr/beaver/dloads/${P}.tar.gz"
HOMEPAGE="http://eturquin.free.fr/beaver/index.htm"

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
