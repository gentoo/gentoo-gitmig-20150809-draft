# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/oinkmaster/oinkmaster-1.1.ebuild,v 1.1 2005/01/13 10:08:13 dragonheart Exp $

inherit eutils

DESCRIPTION="Rule management for SNORT"
SRC_URI="mirror://sourceforge/oinkmaster/${P}.tar.gz"
HOMEPAGE="http://oinkmaster.sf.net/"
IUSE="X"

DEPEND=""
RDEPEND=">=dev-lang/perl-5.6.1
	X? ( dev-perl/perl-tk )
	net-misc/wget
	app-arch/tar
	app-arch/gzip"

SLOT="0"
LICENSE="BSD"

KEYWORDS="~x86"

src_install() {
	dobin oinkmaster.pl contrib/create-sidmap.pl contrib/addsid.pl contrib/makesidex.pl contrib/addmsg.pl
	use X && dobin contrib/oinkgui.pl
	dodoc FAQ UPGRADING README README.win32 README.gui LICENSE INSTALL contrib/README.contrib
	doman oinkmaster.1
	insinto /etc
	doins oinkmaster.conf
}
