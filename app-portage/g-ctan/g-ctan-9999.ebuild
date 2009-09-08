# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-ctan/g-ctan-9999.ebuild,v 1.5 2009/09/08 17:59:06 fauli Exp $

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
RDEPEND="~app-text/texlive-2008
	|| ( app-arch/xz-utils app-arch/lzma-utils[-nocxx] )
	>=dev-libs/libpcre-0.7.6"

src_install() {
	emake DESTDIR="${D}" install || die
}
