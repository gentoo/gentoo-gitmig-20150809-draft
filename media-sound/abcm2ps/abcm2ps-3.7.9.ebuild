# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcm2ps/abcm2ps-3.7.9.ebuild,v 1.6 2004/09/14 07:16:36 eradicator Exp $

IUSE=""

inherit gnuconfig

DESCRIPTION="A program to convert abc files to Postscript files"
HOMEPAGE="http://moinejf.free.fr/"
SRC_URI="http://moinejf.free.fr/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc"
DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install() {
	einstall || die
	dodoc README abc-draft.txt Changes INSTALL
}
