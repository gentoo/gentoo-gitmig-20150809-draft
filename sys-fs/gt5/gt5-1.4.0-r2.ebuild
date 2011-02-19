# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gt5/gt5-1.4.0-r2.ebuild,v 1.1 2011/02/19 16:58:42 angelos Exp $

inherit eutils

DESCRIPTION="a diff-capable 'du-browser'"
HOMEPAGE="http://gt5.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="|| ( www-client/links
		www-client/elinks
		www-client/lynx )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-bash-shabang.patch" \
		"${FILESDIR}/${P}-empty-dirs.patch"
}

src_install() {
		dobin gt5
		doman gt5.1
		dodoc Changelog README
}
