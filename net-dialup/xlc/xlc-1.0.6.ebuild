# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xlc/xlc-1.0.6.ebuild,v 1.1 2004/11/28 10:44:06 mrness Exp $

DESCRIPTION="GTK client for LineControl server"
HOMEPAGE="http://linecontrol.sourceforge.net"
SRC_URI="mirror://sourceforge/linecontrol/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql"

DEPEND=">=x11-libs/gtk+-1.2
	mysql? ( dev-db/mysql )"

src_compile() {
	econf `use_enable mysql` || die "could not configure"

	#Comment silly CFLAGS
	sed -i -e 's:^CFLAGS = .*:#&:' src/Makefile

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
