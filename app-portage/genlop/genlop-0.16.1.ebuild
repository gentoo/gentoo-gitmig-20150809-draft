# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/genlop/genlop-0.16.1.ebuild,v 1.1 2003/08/15 12:09:30 lanius Exp $

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="http://freshmeat.net/projects/genlop/"

SRC_URI="http://pollycoke.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
S=${WORKDIR}/${P}

DEPEND="sys-apps/tar
		sys-apps/gzip"
RDEPEND=">=dev-lang/perl-5.8.0-r10"

RESTRICT="nostrip"

src_install() {
	dobin genlop
	dodoc README
}
