# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoolkit/gentoolkit-0.1.21-r2.ebuild,v 1.1 2003/04/30 09:22:03 liquidx Exp $

DESCRIPTION="Collection of unofficial administration scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

DEPEND=">=dev-lang/python-2.0
	>=dev-util/dialog-0.7
	>=dev-lang/perl-5.6
	>=sys-apps/grep-2.5-r1"

src_install() {
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

	dobin ${FILESDIR}/scripts/etcat
	doman ${FILESDIR}/scripts/etcat.1

	dobin ${FILESDIR}/scripts/pkg-size
# 2002-08-06: karltk
# This utility currently does more harm than good. I'm not including it
# until it has been fixed properly. See #5777 in particular.
#	dobin ${FILESDIR}/scripts/useflag
#	doman ${FILESDIR}/scripts/useflag.1

	dosbin ${FILESDIR}/scripts/pkg-clean
	dosbin ${FILESDIR}/scripts/mkebuild

#	dobin ${FILESDIR}/lintool/lintool
#	doman ${FILESDIR}/lintool/lintool.1
#	docinto lintool
#	dodoc ${FILESDIR}/lintool/{checklist-for-ebuilds,ChangeLog}

	dobin ${FILESDIR}/scripts/echangelog
	doman ${FILESDIR}/scripts/echangelog.1
	dobin ${FILESDIR}/scripts/ekeyword
}

pkg_postinst() {
	ewarn "The 'useflag' utility has been removed, pending an overhaul. It has proven to be too brittle to be used safely."
	einfo ""
	einfo "since epm is now it's own package please emerge it yourself sys-apps/epm" 
	einfo ""
	einfo "if you are upgrading from gentoolkit-0.1.17-r7 or earlier and"
	einfo "you're using mkebuild, please remove ~/.mkebuild to update your settings"
	einfo ""
	einfo "dep-clean has been re-incarnated at the request of dragon.  The new version"
	einfo "is much faster and better than the old one, and is included herein"
	einfo ""
	einfo "emerge-webrsync is now in sys-apps/portage (2.0.47+) included"
	einfo ""

}
