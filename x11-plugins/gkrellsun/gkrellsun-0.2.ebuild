# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellsun/gkrellsun-0.2.ebuild,v 1.6 2003/02/13 17:26:26 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin that shows sunrise and sunset times."
SRC_URI="http://nwalsh.com/hacks/gkrellsun/${P}.tar.gz"
HOMEPAGE="http://nwalsh.com/hacks/gkrellsun"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

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
