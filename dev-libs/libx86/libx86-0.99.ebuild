# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libx86/libx86-0.99.ebuild,v 1.6 2008/09/06 20:44:56 ulm Exp $

inherit eutils multilib

DESCRIPTION="A hardware-independent library for executing real-mode x86 code"
HOMEPAGE="http://www.codon.org.uk/~mjg59/libx86"
SRC_URI="http://www.codon.org.uk/~mjg59/libx86/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	# fix compile failure with linux-headers-2.6.26, bug 235599
	epatch "${FILESDIR}"/${PN}-0.99-ifmask.patch
}

src_compile() {
	local ARGS
	if use amd64; then
		ARGS="BACKEND=x86emu"
	fi
	emake ${ARGS} || die
}

src_install() {
	emake install LIBDIR="/usr/$(get_libdir)" DESTDIR="${D}" || die
}
