# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ctrlxmms/ctrlxmms-1.1.ebuild,v 1.9 2005/09/14 07:11:09 agriffis Exp $

DESCRIPTION="A script to control XMMS from the command line"
SRC_URI="http://files.smidsrod.no/${P}.tar.gz"
HOMEPAGE="http://www.smidsrod.no"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc sparc x86"

IUSE=""

DEPEND="dev-perl/Xmms-Perl
	media-sound/xmms"

src_install () {
	exeinto /usr/bin
	doexe ctrlxmms
	dodoc README
}
