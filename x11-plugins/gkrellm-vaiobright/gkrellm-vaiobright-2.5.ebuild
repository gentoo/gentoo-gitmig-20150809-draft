# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-vaiobright/gkrellm-vaiobright-2.5.ebuild,v 1.1 2003/03/16 19:20:27 liquidx Exp $

IUSE=""

MY_P=${P/gkrellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Superslim VAIO LCD Brightness Control Plugin for Gkrellm"
SRC_URI="http://nerv-nu.net/~dragorn/code/${MY_P}.tar.gz"
HOMEPAGE="http://nerv-nu.net/~dragorn/"

DEPEND=">=app-admin/gkrellm-2.0"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 -*"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins vaiobright.so
	dodoc README
}
