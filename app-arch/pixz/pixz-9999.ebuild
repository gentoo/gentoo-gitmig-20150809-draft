# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pixz/pixz-9999.ebuild,v 1.1 2012/11/13 23:37:20 zerochaos Exp $

EAPI=4

inherit git-2

DESCRIPTION="Parallel Indexed XZ compressor"
HOMEPAGE="https://github.com/vasi/pixz"
EGIT_REPO_URI="https://github.com/vasi/pixz.git"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=app-arch/libarchive-2.8
	>=app-arch/xz-utils-5"
RDEPEND="${DEPEND}"

src_install() {
	dobin pixz
}
