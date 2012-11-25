# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pixz/pixz-1.0.ebuild,v 1.1 2012/11/25 02:10:01 zerochaos Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Parallel Indexed XZ compressor"
HOMEPAGE="https://github.com/vasi/pixz"

if [[ ${PV} == "9999" ]] ; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/vasi/pixz.git"
	KEYWORDS=""
else
	SRC_URI="mirror://github/vasi/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND=">=app-arch/libarchive-2.8
	>=app-arch/xz-utils-5"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" OPT=""
}

src_install() {
	dobin pixz
	dodoc README TODO
}
