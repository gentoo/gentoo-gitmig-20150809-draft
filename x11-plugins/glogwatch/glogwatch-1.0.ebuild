# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/glogwatch/glogwatch-1.0.ebuild,v 1.1 2002/08/30 07:44:13 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Gkrellm plugin that tracks a log file."
SRC_URI="http://www.uberh4x0r.org/download/gkrellm/${P}.tar.gz"
HOMEPAGE="http://www.uberh4x0r.org/download/gkrellm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="=app-admin/gkrellm-1.2*"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe glogwatch.so
	dodoc README COPYRIGHT
}
