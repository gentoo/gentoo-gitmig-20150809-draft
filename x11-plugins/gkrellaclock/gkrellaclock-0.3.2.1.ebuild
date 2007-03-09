# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellaclock/gkrellaclock-0.3.2.1.ebuild,v 1.10 2007/03/09 15:56:35 lack Exp $

inherit gkrellm-plugin

IUSE=""
S=${WORKDIR}/${P/a/A}
DESCRIPTION="Nice analog clock for GKrellM2"
SRC_URI="http://www.geocities.com/m_muthukumar/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/m_muthukumar/gkrellaclock.html"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ppc amd64"

src_compile() {
	export CFLAGS="${CFLAGS/-O?/}"
	emake || die
}
