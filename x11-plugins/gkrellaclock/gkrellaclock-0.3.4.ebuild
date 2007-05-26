# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellaclock/gkrellaclock-0.3.4.ebuild,v 1.7 2007/05/26 12:50:47 opfer Exp $

inherit gkrellm-plugin

IUSE=""
S=${WORKDIR}/${P/a/A}
DESCRIPTION="Nice analog clock for GKrellM2"
SRC_URI="http://www.geocities.com/m_muthukumar/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/m_muthukumar/gkrellaclock.html"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ppc sparc x86"

src_compile() {
	make clean #166133

	export CFLAGS="${CFLAGS/-O?/}"
	emake || die 'emake failed'
}

