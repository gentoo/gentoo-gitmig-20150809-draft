# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.2.0_beta2.ebuild,v 1.4 2004/01/17 11:20:57 aliz Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE educational apps"
KEYWORDS="~x86 ~sparc ~amd64"

src_unpack() {
	kde_src_unpack
	use sparc && epatch ${FILESDIR}/kdeedu-3.2.0_beta2-sparc-lx200.patch
}

