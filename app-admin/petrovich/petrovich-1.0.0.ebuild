# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/petrovich/petrovich-1.0.0.ebuild,v 1.5 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/petrovich
DESCRIPTION="Filesystem Integrity Checker"
SRC_URI="http://prdownloads.sf.net/petrovich/${PF}.tar.gz"
SLOT="0"
HOMEPAGE="http://sourceforge.net/projects/petrovich"
LICENSE="GPL-2"

#build-time dependencies
DEPEND="sys-devel/perl"
RDEPEND="dev-perl/Digest-MD5"

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

