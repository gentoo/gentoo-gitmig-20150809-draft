# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-0.1.37.ebuild,v 1.3 2003/12/17 05:02:37 brad_mssw Exp $

DESCRIPTION="Collection of unofficial administration scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha mips hppa arm amd64 ia64 ppc64"

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

	dobin ${FILESDIR}/scripts/revdep-rebuild
	doman ${FILESDIR}/scripts/revdep-rebuild.1
	fperms 0750 /usr/bin/revdep-rebuild

	dobin ${FILESDIR}/scripts/etcat
	doman ${FILESDIR}/scripts/etcat.1

	dobin ${FILESDIR}/scripts/ewhich
	doman ${FILESDIR}/scripts/ewhich.1

	dobin ${FILESDIR}/scripts/pkg-size
	doman ${FILESDIR}/scripts/pkg-size.1
# 2002-08-06: karltk
# This utility currently does more harm than good. I'm not including it
# until it has been fixed properly. See #5777 in particular.
#	dobin ${FILESDIR}/scripts/useflag
#	doman ${FILESDIR}/scripts/useflag.1

	dobin ${FILESDIR}/euse/euse
	doman ${FILESDIR}/euse/euse.1
	docinto euse
	dodoc ${FILESDIR}/euse/{ChangeLog,README}

	dosbin ${FILESDIR}/scripts/pkg-clean
	doman ${FILESDIR}/scripts/pkg-clean.1

	dosbin ${FILESDIR}/scripts/mkebuild
	doman ${FILESDIR}/scripts/mkebuild.1

#	dobin ${FILESDIR}/lintool/lintool
#	doman ${FILESDIR}/lintool/lintool.1
#	docinto lintool
#	dodoc ${FILESDIR}/lintool/{checklist-for-ebuilds,ChangeLog}

	dobin ${FILESDIR}/scripts/echangelog
	doman ${FILESDIR}/scripts/echangelog.1

	dobin ${FILESDIR}/scripts/ekeyword
	doman ${FILESDIR}/scripts/ekeyword.1
}
