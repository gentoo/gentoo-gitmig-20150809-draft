# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/chkfontpath/chkfontpath-1.9.10.ebuild,v 1.6 2004/07/14 17:04:33 agriffis Exp $

IUSE=""

inherit rpm eutils

RPM_V="2"

DESCRIPTION="Simple interface for editing the font path for the X font server"
HOMEPAGE="ftp://ftp.redhat.com/pub/redhat/linux/rawhide/SRPMS/SRPMS/"
SRC_URI="ftp://rpmfind.net/linux/rawhide/1.0/SRPMS/SRPMS/${P}-${RPM_V}.src.rpm
	mirror://gentoo/${P}-gentoo.patch.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips"

DEPEND="virtual/libc
	app-arch/rpm2targz
	dev-libs/popt"

RDEPEND="${DEPEND}
	sys-apps/psmisc"


src_unpack() {
	rpm_src_unpack
	cd ${S}
	epatch ${DISTDIR}/${P}-gentoo.patch.bz2
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/X11R6/bin
	doexe chkfontpath

	doman man/en/chkfontpath.8
}
