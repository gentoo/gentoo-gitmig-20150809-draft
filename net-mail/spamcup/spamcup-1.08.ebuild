# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/spamcup/spamcup-1.08.ebuild,v 1.4 2004/11/06 04:12:50 dragonheart Exp $

DESCRIPTION="This script does the same you would do when you report spam with your browser in Spamcop.net."
HOMEPAGE="http://sourceforge.net/projects/spamcup/"
SRC_URI="mirror://sourceforge/spamcup/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0
	dev-perl/Getopt-ArgvFile
	dev-perl/libwww-perl"

src_install() {
	dodir /usr/bin
	dobin spamcup

	dodoc ChangeLog INSTALL LICENSE README
}
