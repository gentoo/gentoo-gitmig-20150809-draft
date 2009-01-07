# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/exiftool/exiftool-7.60.ebuild,v 1.1 2009/01/07 18:18:47 graaff Exp $

inherit perl-module

DESCRIPTION="Read and write meta information in image, audio and video files"
HOMEPAGE="http://www.sno.phy.queensu.ca/~phil/exiftool/"
SRC_URI="http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-${PV}.tar.gz"

MY_PN="Image-ExifTool"
LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
S="${WORKDIR}"/${MY_PN}-${PV}

SRC_TEST="do"

src_compile() {
	perl Makefile.PL DESTDIR="${D}" || die "Invalid Makefile.PL"
	emake || die "Compilation failed"
}

src_install() {
	emake install || die "Installation failed"
	fixlocalpod
	dodoc Changes README
	dohtml -r html/
	dobin exiftool
}
