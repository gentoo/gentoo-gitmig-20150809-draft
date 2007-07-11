# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-vaiobright/gkrellm-vaiobright-2.5-r1.ebuild,v 1.4 2007/07/11 20:39:22 mr_bones_ Exp $

inherit gkrellm-plugin

IUSE=""

MY_P=${P/gkrellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Superslim VAIO LCD Brightness Control Plugin for Gkrellm"
SRC_URI="http://nerv-un.net/~dragorn/code/${MY_P}.tar.gz"
HOMEPAGE="http://nerv-un.net/~dragorn/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="-* x86"

PLUGIN_SO=vaiobright.so

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-textrel.patch" || die "Patch failed"
	epatch "${FILESDIR}/${P}-fixinfo.patch" || die "Patch failed"
}
