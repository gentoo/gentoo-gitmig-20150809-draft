# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmitime/gkrellmitime-1.0.ebuild,v 1.5 2003/02/13 17:24:55 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Internet Time plugin for Gkrellm2"
SRC_URI="http://eric.bianchi.free.fr/gkrellm/${P}.tar.gz"
HOMEPAGE="http://eric.bianchi.free.fr/gkrellm/"

DEPEND=">=app-admin/gkrellm-2*"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc "

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins gkrellm_itime.so
	dodoc README ChangeLog COPYING
}
