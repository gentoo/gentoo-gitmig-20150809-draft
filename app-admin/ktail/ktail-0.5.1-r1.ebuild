# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/ktail/ktail-0.5.1-r1.ebuild,v 1.8 2002/07/25 12:57:05 seemant Exp $

inherit kde-base || die

need-kde 2

DESCRIPTION="ktail monitors multiple files and/or command output in one window."
SRC_URI="http://www.franken.de/users/duffy1/rjakob/${P}.tar.gz"
HOMEPAGE="http://www.franken.de/users/duffy1/rjakob/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	base_src_unpack
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}
