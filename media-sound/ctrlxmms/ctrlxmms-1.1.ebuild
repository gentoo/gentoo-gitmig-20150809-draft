# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ctrlxmms/ctrlxmms-1.1.ebuild,v 1.1 2003/07/30 11:58:43 mcummings Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A script to control XMMS from the command line"
SRC_URI="http://www.smidsrod.no/download/ctrlxmms-1.1.tar.gz"
HOMEPAGE="http://www.smidsrod.no"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="dev-perl/Xmms-Perl
	media-sound/xmms"


src_install () {
	exeinto /usr/bin
	doexe ctrlxmms
	dodoc README
}
