# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/oinkmaster/oinkmaster-0.9.ebuild,v 1.1 2004/02/17 06:28:05 mboman Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Rule management for SNORT"
SRC_URI="mirror://sourceforge/oinkmaster/${P}.tar.gz"
HOMEPAGE="http://oinkmaster.sf.net/"

DEPEND=""
RDEPEND="dev-lang/perl
	net-misc/wget
	app-arch/tar
	app-arch/gzip"

SLOT="0"
LICENSE="BSD"

KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-oinkmaster.conf.patch
}

src_install() {
	dobin oinkmaster.pl contrib/addmsg.pl contrib/makesidex.pl
	dodoc ChangeLog LICENSE README INSTALL UPGRADING contrib/README.contrib
	insinto /etc
	doins oinkmaster.conf
}

