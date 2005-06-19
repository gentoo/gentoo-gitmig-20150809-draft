# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakd/lineakd-0.8.3.ebuild,v 1.2 2005/06/19 20:43:16 smithj Exp $

IUSE=""
MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"

DEPEND="virtual/x11"


src_compile() {
	econf --with-x || die
	emake || die
}

src_install () {
	make DESTDIR=${D} lineakddocdir=/usr/share/doc/${P} install || die
	dodoc AUTHORS COPYING INSTALL README TODO
	keepdir /usr/lib/lineakd/plugins

	insinto /etc/lineak
	doins lineakd.conf.example
	doins lineakd.conf.kde.example
}
