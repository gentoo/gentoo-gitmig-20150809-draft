# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/passook/passook-0.5.0.ebuild,v 1.6 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}
DESCRIPTION="Password generator capable of generating pronounceable and/or secure passwords."
SRC_URI="ftp://mackers.com/pub/scripts/passook.tar.gz"
HOMEPAGE="http://mackers.com/misc/scripts/passook/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

DEPEND="sys-devel/perl
	sys-apps/grep
	sys-apps/miscfiles"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/passook.diff || die
}

src_install() {
	dobin passook
	dodoc README passook.cgi
}
