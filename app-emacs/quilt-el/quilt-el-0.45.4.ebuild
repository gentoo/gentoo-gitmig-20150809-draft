# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/quilt-el/quilt-el-0.45.4.ebuild,v 1.9 2009/02/19 19:18:44 nixnut Exp $

inherit elisp eutils

DESCRIPTION="Quilt mode for Emacs"
HOMEPAGE="http://stakeuchi.sakura.ne.jp/dev/quilt-el/"
SRC_URI="http://stakeuchi.sakura.ne.jp/dev/quilt-el/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-util/quilt"

S="${WORKDIR}/${PN}"
SITEFILE=50${PN}-gentoo.el
DOCS="README changelog"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-tramp-recursion.patch"
	epatch "${FILESDIR}/${P}-header-window.patch"
}
