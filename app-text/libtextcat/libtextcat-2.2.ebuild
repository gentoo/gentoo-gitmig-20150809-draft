# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libtextcat/libtextcat-2.2.ebuild,v 1.1 2011/08/09 14:32:04 scarabeus Exp $

EAPI=4

inherit base autotools

DESCRIPTION="Library implementing N-gram-based text categorization"
HOMEPAGE="http://software.wise-guys.nl/libtextcat/"
SRC_URI="
	http://software.wise-guys.nl/download/${P}.tar.gz
	http://hg.services.openoffice.org/hg/DEV300/raw-file/tip/libtextcat/data/new_fingerprints/fpdb.conf

"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PV}-catalan-shorttexts.patch"
	"${FILESDIR}/${PV}-exportapi.patch"
	"${FILESDIR}/${PV}-openoffice.patch"
)

src_prepare() {
	# fix path to the data
	sed -i \
		-e "s:LM:${EPREFIX}/usr/share/LM:g" \
		langclass/conf.txt || die

	ecvs_clean
	base_src_prepare
	eautoreconf
}

src_configure() {
	econf \
		--disable-static
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +

	insinto /usr/share/${PN}

	doins -r langclass/*
	doins ${DISTDIR}/fpdb.conf
}
