# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Chad Huneycutt <chad.huneycutt@acm.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/petrovich/petrovich-1.0.0.ebuild,v 1.1 2001/08/07 01:20:08 chadh Exp $

S=${WORKDIR}/petrovich
DESCRIPTION="Filesystem Integrity Checker"
SRC_URI="http://prdownloads.sf.net/petrovich/${PF}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/petrovich"

#build-time dependencies
DEPEND="sys-devel/perl"

#run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

src_unpack () {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_install () {
	into /usr
	dosbin petrovich.pl

	insinto /etc
	doins ${FILESDIR}/petrovich.conf

	dodir /var/db/petrovich

	dodoc CHANGES.HTML LICENSE.HTML README.HTML TODO.HTML USAGE.HTML
}

