# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jerry A! <jerry@thehutt.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellmitime/gkrellmitime-0.4.ebuild,v 1.4 2002/07/08 21:31:06 aliz Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Internet Time plugin for Gkrellm"
SRC_URI="http://eric.bianchi.free.fr/gkrellm/${P}.tar.gz"

HOMEPAGE="http://eric.bianchi.free.fr/gkrellm/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=app-admin/gkrellm-1.2.4"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins gkrellm_itime.so
	dodoc README ChangeLog COPYING
}
