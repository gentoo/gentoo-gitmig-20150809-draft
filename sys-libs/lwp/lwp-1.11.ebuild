# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lwp/lwp-1.11.ebuild,v 1.3 2004/06/24 23:07:28 agriffis Exp $

inherit eutils

DESCRIPTION="Light weight process library (used by Coda).  This is NOT libwww-perl."
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/lwp/src/${P}.tar.gz"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~mips ~amd64 ~ia64"
IUSE=""

DEPEND="virtual/glibc
	sys-apps/grep
	sys-apps/sed
	sys-devel/libtool
	sys-devel/gcc"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}

	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog NEWS PORTING README
}
