# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/petrovich/petrovich-1.0.0.ebuild,v 1.8 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Filesystem Integrity Checker"
SRC_URI="http://prdownloads.sf.net/petrovich/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/petrovich"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="dev-perl/Digest-MD5"
RDEPEND="${DEPEND}"

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

	dohtml CHANGES.HTML LICENSE.HTML README.HTML TODO.HTML USAGE.HTML
}
