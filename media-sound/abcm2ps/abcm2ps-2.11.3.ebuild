# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcm2ps/abcm2ps-2.11.3.ebuild,v 1.1 2002/11/16 06:57:22 satai Exp $

DESCRIPTION="A program to convert abc files to Postscript files"
HOMEPAGE="http://moinejf.free.fr/"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
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
