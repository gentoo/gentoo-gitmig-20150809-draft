# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mirrorselect/mirrorselect-0.2-r1.ebuild,v 1.3 2003/03/11 21:11:43 seemant Exp $

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha ~mips hppa"

RDEPEND=">=dev-util/dialog-0.7
        sys-apps/grep
    	sys-apps/sed
	net-analyzer/netselect
        dev-lang/perl"

src_install() {
	dosbin ${FILESDIR}/mirrorselect
}
