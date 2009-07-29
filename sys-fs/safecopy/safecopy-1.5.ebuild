# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/safecopy/safecopy-1.5.ebuild,v 1.1 2009/07/29 22:44:56 scarabeus Exp $

EAPI=2
inherit base

DESCRIPTION="Data recovery tool to fault-tolerantly extract data from damaged (io-errors) devices or files."
HOMEPAGE="http://safecopy.sourceforge.net"
SRC_URI="mirror://sourceforge/safecopy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND=""

src_prepare() {
	sed -e 's:bin/sh:bin/bash:' \
		-i "${S}"/test/test.sh || die "sed failed"
}

src_configure() {
	base_src_configure
	if use test; then
		cd "${S}"/simulator
		econf
	fi
}

src_compile() {
	base_src_compile
	if use test; then
		cd "${S}"/simulator
		emake || die "Simulator compilation failed -- needed for testing"
	fi
}

src_install() {
	base_src_install
	dodoc README || die "copying documentation failed"
}

src_test() {
	cd "${S}"/test
	./test.sh || die "./tesh.sh failed"
}
