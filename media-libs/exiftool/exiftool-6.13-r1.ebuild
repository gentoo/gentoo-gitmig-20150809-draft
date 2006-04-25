# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/exiftool/exiftool-6.13-r1.ebuild,v 1.2 2006/04/25 00:20:46 deltacow Exp $

inherit perl-module

DESCRIPTION="Read and write meta information from EXIF"
HOMEPAGE="http://www.sno.phy.queensu.ca/~phil/exiftool/"
SRC_URI="http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-${PV}.tar.gz"

MY_PN="Image-ExifTool"
LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S=${WORKDIR}/${MY_PN}-${PV}


src_compile() {
	perl Makefile.PL DESTDIR="${D}" || die "Invalid Makefile.PL"
	emake || die "Compilation failed"
}

src_install() {
	make install || die "Installation failed"
	fixlocalpod
	dodoc Changes README
	dohtml -r html/
	dobin exiftool
}
