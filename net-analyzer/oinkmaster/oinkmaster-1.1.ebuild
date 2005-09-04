# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/oinkmaster/oinkmaster-1.1.ebuild,v 1.4 2005/09/04 03:22:41 dragonheart Exp $

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

KEYWORDS="x86 ~amd64"

src_install() {
	dobin oinkmaster.pl contrib/create-sidmap.pl contrib/addsid.pl contrib/makesidex.pl contrib/addmsg.pl
	use X && dobin contrib/oinkgui.pl
	dodoc FAQ UPGRADING README README.win32 README.gui contrib/README.contrib
	doman oinkmaster.1
	insinto /etc
	sed -e 's|^url.*|url = http://www.snort.org/pub-bin/downloads.cgi/Download/comm_rules/Community-Rules.tar.gz|' \
		oinkmaster.conf > ${D}/etc/oinkmaster.conf
}
