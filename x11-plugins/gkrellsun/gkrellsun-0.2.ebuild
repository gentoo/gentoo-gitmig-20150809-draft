# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellsun/gkrellsun-0.2.ebuild,v 1.2 2002/08/30 05:14:58 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin that shows sunrise and sunset times."
SRC_URI="http://nwalsh.com/hacks/gkrellsun/${P}.tar.gz"
HOMEPAGE="http://nwalsh.com/hacks/gkrellsun"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="=app-admin/gkrellm-1.2*
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins gkrellsun.so
	dodoc README AUTHORS COPYING
}
