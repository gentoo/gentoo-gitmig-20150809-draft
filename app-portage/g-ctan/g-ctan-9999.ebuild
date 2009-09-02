# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-ctan/g-ctan-9999.ebuild,v 1.1 2009/09/02 16:41:07 fauli Exp $

EAPI=2

inherit bzr

DESCRIPTION="Generate and install ebuilds from the TeXLive package manager"
HOMEPAGE="http://launchpad.net/g-ctan"
SRC_URI=""
LICENSE="GPL-3"

EBZR_REPO_URI="lp:g-ctan"

SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=""
RDEPEND="app-arch/lzma-utils[-nocxx]
	>=dev-libs/libpcre-0.7.6"

src_install() {
	dobin g-ctan

	insinto /etc/g-ctan
	doins g-ctan.conf

	insinto /usr/share/g-ctan
	doins modules/*

	keepdir /var/cache/g-ctan/
}
