# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/mirrorselect/mirrorselect-1.4.2.ebuild,v 1.1 2009/06/21 21:34:05 zmedico Exp $

inherit eutils

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PF%.*}.tar.bz2 mirror://gentoo/$PF.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh
~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-util/dialog-0.7
	net-analyzer/netselect"

S=$WORKDIR

src_unpack() {
	unpack $A
	epatch $PF.patch
}

src_install() {
	dosbin mirrorselect || die
}
