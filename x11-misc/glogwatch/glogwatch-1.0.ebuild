# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glogwatch/glogwatch-1.0.ebuild,v 1.5 2002/07/11 06:30:57 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Gkrellm plugin that tracks a log file."
SRC_URI="http://www.uberh4x0r.org/download/gkrellm/${P}.tar.gz"
HOMEPAGE="http://www.uberh4x0r.org/download/gkrellm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=app-admin/gkrellm-1.0.6
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe glogwatch.so
	dodoc README COPYRIGHT
}
