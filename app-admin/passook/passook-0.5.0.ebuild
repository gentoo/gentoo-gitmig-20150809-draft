# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/passook/passook-0.5.0.ebuild,v 1.2 2002/04/27 21:46:44 bangert Exp $

S=${WORKDIR}
DESCRIPTION="Password generator capable of generating pronounceable and/or secure passwords."
SRC_URI="ftp://mackers.com/pub/scripts/passook.tar.gz"
HOMEPAGE="http://mackers.com/misc/scripts/passook/"

DEPEND="sys-devel/perl
	sys-apps/grep
	sys-apps/miscfiles"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/passook.diff
}

src_install() {

	dobin passook
	dodoc README passook.cgi

}
