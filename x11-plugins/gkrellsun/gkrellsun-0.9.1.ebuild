# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellsun/gkrellsun-0.9.1.ebuild,v 1.4 2003/09/04 13:46:04 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin that shows sunrise and sunset times."
SRC_URI="mirror://sourceforge/gkrellsun/${P}.tar.gz"
HOMEPAGE="http://gkrellsun.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="app-admin/gkrellm
	>=media-libs/imlib-1.9.10-r1"

src_compile() {

	if [ -f /usr/bin/gkrellm ]
	then
		cd ${S}/src
		emake || die
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		cd ${S}/src20
		emake || die
	fi

}

src_install () {

	dodoc README AUTHORS COPYING

	if [ -f /usr/bin/gkrellm ]
	then
		cd ${S}/src
		insinto /usr/lib/gkrellm/plugins
		doins gkrellsun.so
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		cd ${S}/src20
		insinto /usr/lib/gkrellm2/plugins
		doins gkrellsun.so
	fi
}
