# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmitime/gkrellmitime-1.0.1.ebuild,v 1.6 2004/03/26 23:10:05 aliz Exp $

IUSE=""
DESCRIPTION="Internet Time plugin for Gkrellm2"
HOMEPAGE="http://eric.bianchi.free.fr/gkrellm/"
SRC_URI="http://eric.bianchi.free.fr/Softwares/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc sparc ~alpha"

DEPEND=">=app-admin/gkrellm-2*"

src_compile() {
	make || die
}

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins gkrellm_itime.so
	dodoc README ChangeLog COPYING
}
