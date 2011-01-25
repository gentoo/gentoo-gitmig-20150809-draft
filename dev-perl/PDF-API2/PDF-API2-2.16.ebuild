# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-API2/PDF-API2-2.16.ebuild,v 1.1 2011/01/25 12:19:20 tove Exp $

EAPI=3

MODULE_AUTHOR=SSIMMS
MODULE_VERSION=2.016
inherit perl-module

DESCRIPTION="Facilitates the creation and modification of PDF files"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="virtual/perl-IO-Compress
	dev-perl/Font-TTF
	media-fonts/dejavu"
DEPEND="${RDEPEND}"

SRC_TEST="do"

src_install() {
	perl-module_src_install
	rm -rf "${D}/${VENDOR_LIB}/PDF/API2/fonts" || die
	ln -s /usr/share/fonts/dejavu "${D}/${VENDOR_LIB}/PDF/API2/fonts" || die
}

pkg_postinst() {
	if [[ ! -h ${ROOT}${VENDOR_LIB}/PDF/API2/fonts ]] ; then
		einfo "Creating symlink ${ROOT}${VENDOR_LIB}/PDF/API2/fonts"
		ln -s /usr/share/fonts/dejavu "${ROOT}${VENDOR_LIB}/PDF/API2/fonts"
	fi
}
