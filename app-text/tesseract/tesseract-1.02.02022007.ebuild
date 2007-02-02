# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tesseract/tesseract-1.02.02022007.ebuild,v 1.1 2007/02/02 21:34:24 chutzpah Exp $

inherit eutils multilib

DESCRIPTION="A commercial quality OCR engine developed at HP in the 80's and early 90's."
HOMEPAGE="http://sourceforge.net/projects/tesseract-ocr/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
#SRC_URI="mirror://sourceforge/tesseract-ocr/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-libs/tiff"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/tesseract-1.0.xterm-path.patch
}

src_install() {
	local dest="/usr/$(get_libdir)/${PN}"

	dodir "${dest}"

	exeinto "${dest}"
	doexe ccmain/tesseract

	dodir "${dest}/tessdata/configs"
	dodir "${dest}/tessdata/tessconfigs"

	insinto "${dest}/tessdata"
	doins tessdata/*

	insinto "${dest}/tessdata/configs"
	doins tessdata/configs/*

	insinto "${dest}/tessdata/tessconfigs"
	doins tessdata/tessconfigs/*

	dodoc README AUTHORS phototest.tif

	echo -e "#!/bin/sh\n${dest}/${PN} \"\${@}\"" > ${PN}.sh
	newbin ${PN}.sh ${PN}
}
