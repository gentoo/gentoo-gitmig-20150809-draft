# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmupmon/wmupmon-0.1.1a.ebuild,v 1.1 2003/06/06 22:52:39 robh Exp $

S=${WORKDIR}/${P}

DESCRIPTION="wmUpMon is a program to monitor your Uptime"
HOMEPAGE="http://jzs.mine.nu/projects/index.php?project=wmupmon"
SRC_URI="http://jzs.mine.nu/projects/downloads/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="sys-devel/automake
	sys-devel/autoconf
	virtual/x11
	media-libs/xpm"

src_compile() {
	
	# This is needed specifically for depcomp, which is necessary for
	# building wmupmon, but isn't included -- Is there a better way?
	#cp ${FILESDIR}/depcomp .
	econf || die "configure failed"

	emake  || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc AUTHORS COPYING INSTALL README THANKS ChangeLog
}
