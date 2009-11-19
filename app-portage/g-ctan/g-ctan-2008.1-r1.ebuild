# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-ctan/g-ctan-2008.1-r1.ebuild,v 1.2 2009/11/19 08:16:48 fauli Exp $

EAPI=2

inherit eutils

DESCRIPTION="Generate and install ebuilds from the TeXLive package manager"
HOMEPAGE="http://launchpad.net/g-ctan"
SRC_URI="http://launchpad.net/g-ctan/2008/${PV}/+download/${P}.tar.bz2"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=""
RDEPEND="~app-text/texlive-2008
	|| ( app-arch/xz-utils app-arch/lzma-utils[-nocxx] )
	>=dev-libs/libpcre-0.7.6"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-overlay-detection.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
}
