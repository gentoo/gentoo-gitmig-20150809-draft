# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-Create/PDF-Create-1.04.ebuild,v 1.4 2009/11/17 01:58:09 josejx Exp $

EAPI=2

MODULE_AUTHOR=MARKUSB
inherit perl-module

DESCRIPTION="PDF::Create allows you to create PDF documents"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST=do

src_prepare() {
	rm "${S}"/Changes.PL || die
	sed -i "/Changes.PL/d" "${S}"/MANIFEST || die
	perl-module_src_prepare
}
