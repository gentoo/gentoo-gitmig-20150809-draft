# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoolkit/gentoolkit-0.1.14-r1.ebuild,v 1.2 2002/07/17 20:43:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Collection of unofficial administration scripts for Gentoo"
SRC_URI=""
SLOT="0"
HOMEPAGE="http://www.gentoo.org/~karltk/gentoolkit/"
SLOT="0"
DEPEND=">=dev-lang/python-2.0
	>=dev-util/dialog-0.7
	>=sys-devel/perl-5.6"
RDEPEND="$DEPEND"
LICENSE="GPL-2"

KEYWORDS="x86 ppc sparc sparc64"

src_install () {
	dodir /usr/share/gentoolkit

	insinto /usr/share/gentoolkit
	doins ${FILESDIR}/portage-statistics/histogram.awk

	dobin ${FILESDIR}/gentool/gentool-bump-revision
	dobin ${FILESDIR}/gentool/gentool-total-coverage
	dobin ${FILESDIR}/gentool/gentool-author-coverage
	dobin ${FILESDIR}/gentool/gentool-package-count
	docinto gentool
	dodoc ${FILESDIR}/gentool/ChangeLog

	dobin ${FILESDIR}/scripts/qpkg
	doman ${FILESDIR}/scripts/qpkg.1
	fowners root:wheel /usr/bin/qpkg
	fperms 0750 /usr/bin/qpkg

	dobin ${FILESDIR}/scripts/pkg-size
	dobin ${FILESDIR}/scripts/useflag
	doman ${FILESDIR}/scripts/useflag.1

	dosbin ${FILESDIR}/scripts/pkg-clean
	dosbin ${FILESDIR}/scripts/mkebuild
	dosbin ${FILESDIR}/scripts/emerge-webrsync
	dosbin ${FILESDIR}/scripts/epm

	dobin ${FILESDIR}/lintool/lintool
	doman ${FILESDIR}/lintool/lintool.1
	docinto lintool
	dodoc ${FILESDIR}/lintool/{checklist-for-ebuilds,ChangeLog}

	dosbin ${FILESDIR}/etc-update/etc-update
	doman ${FILESDIR}/etc-update/etc-update.1
	docinto etc-update
	dodoc ${FILESDIR}/etc-update/ChangeLog
	insinto /etc	
	doins ${FILESDIR}/etc-update/etc-update.conf

}
