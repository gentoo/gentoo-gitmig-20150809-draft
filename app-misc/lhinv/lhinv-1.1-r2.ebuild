# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lhinv/lhinv-1.1-r2.ebuild,v 1.11 2004/06/28 03:54:01 vapier Exp $

DESCRIPTION="Linux Hardware Inventory"
HOMEPAGE="http://lhinv.sourceforge.net/"
SRC_URI="mirror://sourceforge/lhinv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-lang/perl"

src_compile() {
	cd ${S}/cgi
	sed -i -e "s:^my \$HINV =.*:my \$HINV =\"/usr/bin/lhinv\";:" \
		w3hinv
	cd ..
	make local || die
}

src_install() {
	dobin lhinv || die
	doman lhinv.1
	dodoc AUTHORS BUGS CHANGELOG README TODO
	newdoc cgi/README README.cgi
	insinto /home/httpd/cgi-bin
	insopts -m 755
	doins cgi/w3hinv
}
