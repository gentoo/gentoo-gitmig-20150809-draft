# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/banner/banner-1.3.1.ebuild,v 1.1 2004/07/20 17:15:51 mholzer Exp $

DESCRIPTION="The well known banner program for linux"
HOMEPAGE="http://cedar-solutions.com"
SRC_URI="http://cedar-solutions.com/ftp/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	einstall || die
	dodoc README AUTHORS INSTALL
}
