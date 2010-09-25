# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare/radare-1.4.2.ebuild,v 1.2 2010/09/25 15:18:56 eva Exp $

EAPI="3"

inherit base

DESCRIPTION="Advanced command line hexadecimail editor and more"
HOMEPAGE="http://radare.nopcode.org"
SRC_URI="http://radare.nopcode.org/get/radare-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gui lua vala"

DEPEND="sys-libs/readline
		dev-lang/python
		lua? ( dev-lang/lua )
		vala? ( dev-lang/vala:0 )
		"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_with gui)
}

src_compile() {
	emake -j1 || die "compile failed"
}

src_install() {
	emake DESTDIR="${ED}" install || die "install failed"
}
