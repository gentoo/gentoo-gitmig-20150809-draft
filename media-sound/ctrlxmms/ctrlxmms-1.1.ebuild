# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ctrlxmms/ctrlxmms-1.1.ebuild,v 1.7 2004/09/14 07:30:24 eradicator Exp $

DESCRIPTION="A script to control XMMS from the command line"
SRC_URI="http://files.smidsrod.no/${P}.tar.gz"
HOMEPAGE="http://www.smidsrod.no"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha amd64"

IUSE=""

DEPEND="dev-perl/Xmms-Perl
	media-sound/xmms"

src_install () {
	exeinto /usr/bin
	doexe ctrlxmms
	dodoc README
}
