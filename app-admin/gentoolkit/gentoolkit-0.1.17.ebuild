# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoolkit/gentoolkit-0.1.17.ebuild,v 1.2 2002/09/14 15:51:24 bjb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Collection of unofficial administration scripts for Gentoo"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/~karltk/projects/gentoolkit/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND=">=dev-lang/python-2.0
	>=dev-util/dialog-0.7
	>=sys-devel/perl-5.6
	>=sys-apps/grep-2.5-r1"

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

	dobin ${FILESDIR}/scripts/dep-clean
	doman ${FILESDIR}/scripts/dep-clean.1
	fowners root:wheel /usr/bin/dep-clean
	fperms 0750 /usr/bin/dep-clean

	dobin ${FILESDIR}/scripts/pkg-size
# 2002-08-06: karltk
# This utility currently does more harm than good. I'm not including it
# until it has been fixed properly. See #5777 in particular.
#	dobin ${FILESDIR}/scripts/useflag
#	doman ${FILESDIR}/scripts/useflag.1

	dosbin ${FILESDIR}/scripts/pkg-clean
	dosbin ${FILESDIR}/scripts/mkebuild
	dosbin ${FILESDIR}/scripts/emerge-webrsync
	dosbin ${FILESDIR}/scripts/epm

	dobin ${FILESDIR}/lintool/lintool
	doman ${FILESDIR}/lintool/lintool.1
	docinto lintool
	dodoc ${FILESDIR}/lintool/{checklist-for-ebuilds,ChangeLog}

# Included in portage as of 03 Sep 2002
#	dosbin ${FILESDIR}/etc-update/etc-update
#	doman ${FILESDIR}/etc-update/etc-update.1
#	docinto etc-update
#	dodoc ${FILESDIR}/etc-update/ChangeLog
#	insinto /etc	
#	doins ${FILESDIR}/etc-update/etc-update.conf

}

pkg_postinst() {
	ewarn "The 'useflag' utility has been removed, pending an overhaul. It has proven to be too brittle to be used safely."
	ewarn "The 'etc-update' utility has been moved to portage."
}
