# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ttysnoop/ttysnoop-0.12d.ebuild,v 1.2 2012/09/07 11:04:56 xarthisius Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Tool to snoop on login tty's through another tty-device or pseudo-tty"
HOMEPAGE="http://sysd.org/stas/node/35"
SRC_URI="http://sysd.org/stas/files/active/0/ttysnoop-0.12d.k26.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"/ttysnoop-${PV}.k26

DOCS="README snooptab.dist"

src_prepare(){
	epatch "${FILESDIR}"/pinkbyte_masking.patch
	epatch "${FILESDIR}"/ttysnoop-makefile.patch
}

src_compile(){
	emake CC="$(tc-getCC)"
}

src_install() {
	dodoc ${DOCS}
	dosbin ttysnoop
	dosbin ttysnoops
	doman ttysnoop.8
	insinto /etc
	newins snooptab.dist snooptab
}
