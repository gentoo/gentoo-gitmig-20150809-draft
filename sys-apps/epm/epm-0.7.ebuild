# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/epm/epm-0.7.ebuild,v 1.1 2002/03/27 00:39:50 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="rpm workalike for Gentoo Linux"
SRC_URI="http://www.gentoo.org/~agriffis/epm/${P}.tar.gz"
HOMEPAGE="http://www.gentoo.org/~agriffis/epm/"
RDEPEND=">=sys-devel/perl-5"

src_install () {
	dobin epm
}
