# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-logwatch/gkrellm-logwatch-1.0.ebuild,v 1.6 2004/03/26 23:10:05 aliz Exp $

IUSE=""
MY_P=${P/krellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Gkrellm plugin that tracks a log file."
SRC_URI="http://www.uberh4x0r.org/download/gkrellm/${MY_P}.tar.gz"
HOMEPAGE="http://www.uberh4x0r.org/download/gkrellm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-1.2*"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe glogwatch.so
	dodoc README COPYRIGHT
}
