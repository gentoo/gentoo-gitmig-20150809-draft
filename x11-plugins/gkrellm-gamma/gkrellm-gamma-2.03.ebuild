# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-gamma/gkrellm-gamma-2.03.ebuild,v 1.5 2004/11/06 16:31:07 pyrania Exp $

IUSE=""
DESCRIPTION="A gamma control plugin for gkrellm"
HOMEPAGE="http://sweb.cz/tripie/gkrellm/gamma/"
SRC_URI="http://sweb.cz/tripie/gkrellm/gamma/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc"

DEPEND="=app-admin/gkrellm-2*"

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins gamma.so
	dodoc AUTHORS COPYING README
}
