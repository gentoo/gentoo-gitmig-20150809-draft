# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellsun/gkrellsun-0.9.1.ebuild,v 1.8 2004/03/26 23:10:06 aliz Exp $

IUSE=""
DESCRIPTION="A GKrellM plugin that shows sunrise and sunset times."
HOMEPAGE="http://gkrellsun.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkrellsun/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~hppa amd64 ~ia64"

DEPEND="app-admin/gkrellm
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	if [ -f ${ROOT}/usr/bin/gkrellm ]
	then
		cd ${S}/src
		emake || die
	fi

	if [ -f ${ROOT}/usr/bin/gkrellm2 ]
	then
		cd ${S}/src20
		emake || die
	fi
}

src_install () {
	dodoc README AUTHORS COPYING

	if [ -f ${ROOT}/usr/bin/gkrellm ]
	then
		cd ${S}/src
		insinto /usr/lib/gkrellm/plugins
		doins gkrellsun.so
	fi

	if [ -f ${ROOT}/usr/bin/gkrellm2 ]
	then
		cd ${S}/src20
		insinto /usr/lib/gkrellm2/plugins
		doins gkrellsun.so
	fi
}
