# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bashish/bashish-1.9.21.ebuild,v 1.6 2004/06/29 03:51:55 vapier Exp $

DESCRIPTION="Text console theme engine"
HOMEPAGE="http://bashish.sourceforge.net/"
SRC_URI="mirror://sourceforge/bashish/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	cp InstallBashish{,.orig}
	sed -e "s:read input:input=${D}/usr/share/bashish:" \
	 -e "s:read yesno:yesno=n:" \
		InstallBashish.orig > InstallBashish
}

src_install() {
	dodir /usr/share/bashish
	./InstallBashish || die
	dobin bashish
	dosed /usr/bin/bashish
	insinto /usr/share/bashish/modules/sh/conf
	doins ${FILESDIR}/bashish.conf
}
