# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/epm/epm-0.7.ebuild,v 1.3 2002/07/14 19:20:17 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="rpm workalike for Gentoo Linux"
SRC_URI="http://www.gentoo.org/~agriffis/epm/${P}.tar.gz"
HOMEPAGE="http://www.gentoo.org/~agriffis/epm/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
RDEPEND=">=sys-devel/perl-5"

src_install () {
	dobin epm
}
