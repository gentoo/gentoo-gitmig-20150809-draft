# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/epm/epm-0.8.ebuild,v 1.4 2003/02/13 15:55:05 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="rpm workalike for Gentoo Linux"
SRC_URI="http://www.gentoo.org/~agriffis/epm/${P}.tar.gz"
HOMEPAGE="http://www.gentoo.org/~agriffis/epm/"
KEYWORDS="x86 ppc sparc alpha"
SLOT="0"
LICENSE="GPL-2"
RDEPEND=">=sys-devel/perl-5"

src_install () {
	dobin epm
}
