# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellstock/gkrellstock-0.5.ebuild,v 1.6 2004/01/04 18:36:47 aliz Exp $

S=${WORKDIR}/${P/s/S}
DESCRIPTION="Get Stock quotes plugin for Gkrellm2"
SRC_URI="mirror://sourceforge/gkrellstock/${P}.tar.gz"
HOMEPAGE="http://gkrellstock.sourceforge.net/"

DEPEND=">=app-admin/gkrellm-2*
	dev-perl/libwww-perl
	dev-perl/Finance-Quote"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins gkrellstock.so
	exeinto /usr/X11R6/bin
	doexe GetQuote2
	dodoc README ChangeLog COPYING
}
