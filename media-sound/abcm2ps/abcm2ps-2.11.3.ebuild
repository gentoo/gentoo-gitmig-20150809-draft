# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcm2ps/abcm2ps-2.11.3.ebuild,v 1.3 2003/07/12 20:30:47 aliz Exp $

DESCRIPTION="A program to convert abc files to Postscript files"
HOMEPAGE="http://moinejf.free.fr/"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86"
DEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	emake \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share/ \
		install || die
}
