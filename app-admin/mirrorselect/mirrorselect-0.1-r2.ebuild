# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mirrorselect/mirrorselect-0.1-r2.ebuild,v 1.4 2003/02/24 19:22:12 weeve Exp $

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
SRC_URI=""
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha ~mips hppa"

DEPEND=">=dev-util/dialog-0.7
        sys-apps/grep
    	sys-apps/sed"

src_install() {
	dosbin ${FILESDIR}/mirrorselect
}

