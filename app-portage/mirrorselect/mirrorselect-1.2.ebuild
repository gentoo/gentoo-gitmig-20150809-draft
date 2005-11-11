# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/mirrorselect/mirrorselect-1.2.ebuild,v 1.7 2005/11/11 22:25:52 matsuu Exp $

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PF}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 sh sparc x86"
IUSE=""

RDEPEND=">=dev-util/dialog-0.7
	net-analyzer/netselect"

S=${WORKDIR}

src_install() {
	dosbin ${S}/mirrorselect || die
}
