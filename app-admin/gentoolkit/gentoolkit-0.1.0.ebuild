# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoolkit/gentoolkit-0.1.0.ebuild,v 1.1 2002/01/24 20:45:57 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Collection of unofficial administration scripts for Gentoo"
SRC_URI=""
HOMEPAGE="http://"

DEPEND=""
RDEPEND=">=dev-lang/python-2.0
	>=sys-devel/perl-5.6"

src_install () {
	dodir /usr/share/gentoolkit

	insinto /usr/share/gentoolkit
	doins ${FILESDIR}/coverage/histogram.awk

	dosbin ${FILESDIR}/coverage/total-coverage
	dosbin ${FILESDIR}/coverage/author-coverage

	dosbin ${FILESDIR}/lintool/lintool
	
	dosbin ${FILESDIR}/scripts/etc-update
	dosbin ${FILESDIR}/scripts/pkg-clean
	dosbin ${FILESDIR}/scripts/qpkg
	dosbin ${FILESDIR}/scripts/mkebuild
	dosbin ${FILESDIR}/scripts/emerge-webrsync
	dosbin ${FILESDIR}/scripts/epm

	dodoc ${FILESDIR}/lintool/checklist-for-ebuilds
	
}
