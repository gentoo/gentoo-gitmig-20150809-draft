# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmupmon/wmupmon-0.1.2.ebuild,v 1.1 2004/03/13 22:59:35 pyrania Exp $

S=${WORKDIR}/${P}

DESCRIPTION="wmUpMon is a program to monitor your Uptime"
HOMEPAGE="http://j-z-s.com/projects/index.php?project=wmupmon"
SRC_URI="http://j-z-s.com/projects/downloads/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"

IUSE=""

DEPEND="sys-devel/automake
	sys-devel/autoconf
	virtual/x11"


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
