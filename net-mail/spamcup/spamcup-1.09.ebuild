# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/spamcup/spamcup-1.09.ebuild,v 1.1 2008/06/14 19:33:37 dertobi123 Exp $

DESCRIPTION="This script does the same you would do when you report spam with your browser in Spamcop.net."
HOMEPAGE="http://sourceforge.net/projects/spamcup/"
SRC_URI="mirror://sourceforge/spamcup/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0
	dev-perl/Getopt-ArgvFile
	dev-perl/libwww-perl"

src_install() {
	dodir /usr/bin
	dobin spamcup

	dodoc ChangeLog INSTALL README
}
