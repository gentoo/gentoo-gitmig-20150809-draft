# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcm2ps/abcm2ps-3.7.9.ebuild,v 1.1 2003/09/28 08:04:38 jje Exp $

DESCRIPTION="A program to convert abc files to Postscript files"
HOMEPAGE="http://moinejf.free.fr/"
SRC_URI="http://moinejf.free.fr/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
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
