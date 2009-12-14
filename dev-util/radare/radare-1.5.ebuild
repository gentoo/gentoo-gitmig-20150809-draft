# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare/radare-1.5.ebuild,v 1.1 2009/12/14 21:33:39 deathwing00 Exp $

DESCRIPTION="Advanced command line hexadecimail editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="http://www.radare.org/get/radare-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gui lua vala"

DEPEND="sys-libs/readline
		dev-lang/python
		lua? ( dev-lang/lua )
		vala? ( dev-lang/vala )
		"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_with gui) || die "configure failed"
	emake -j1 || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
