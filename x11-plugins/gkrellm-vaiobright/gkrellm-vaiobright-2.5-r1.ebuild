# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-vaiobright/gkrellm-vaiobright-2.5-r1.ebuild,v 1.1 2007/02/21 15:27:16 lack Exp $

inherit eutils

IUSE=""

MY_P=${P/gkrellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Superslim VAIO LCD Brightness Control Plugin for Gkrellm"
SRC_URI="http://nerv-un.net/~dragorn/code/${MY_P}.tar.gz"
HOMEPAGE="http://nerv-un.net/~dragorn/"

RDEPEND=">=app-admin/gkrellm-2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 -*"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-textrel.patch" || die "Patch failed"
	epatch "${FILESDIR}/${P}-fixinfo.patch" || die "Patch failed"
}

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins vaiobright.so
	dodoc README
}
