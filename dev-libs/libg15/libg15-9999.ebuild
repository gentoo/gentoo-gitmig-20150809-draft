# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libg15/libg15-9999.ebuild,v 1.1 2012/10/08 01:53:12 robbat2 Exp $

EAPI=4
ESVN_PROJECT=g15tools/trunk
ESVN_REPO_URI="https://g15tools.svn.sourceforge.net/svnroot/${ESVN_PROJECT}/${PN}"

inherit subversion base eutils autotools

DESCRIPTION="The libg15 library gives low-level access to the Logitech G15 keyboard"
HOMEPAGE="http://g15tools.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="=virtual/libusb-0*"
RDEPEND=${DEPEND}

DOCS=( AUTHORS README ChangeLog )

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		subversion_src_unpack
	fi
}

src_prepare() {
	if [[ ${PV} = *9999* ]]; then
		subversion_wc_info
	fi
	base_src_prepare
	if [[ ${PV} = *9999* ]]; then
		eautoreconf
	fi
}

src_configure() {
	econf \
		--disable-static
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
