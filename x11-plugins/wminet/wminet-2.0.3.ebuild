# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wminet/wminet-2.0.3.ebuild,v 1.4 2003/09/24 20:38:42 weeve Exp $

S="${WORKDIR}/${PN}.app"

DESCRIPTION="dockapp that displays useful server statistics"
HOMEPAGE="http://www.neotokyo.org/illusion/dock_apps.html"
SRC_URI="http://www.neotokyo.org/illusion/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/x11"

src_unpack() {

	unpack ${A}
	cd ${S}/wminet
	cp Makefile Makefile.orig
	sed -e "s:-O2:$CFLAGS:" Makefile.orig > Makefile

}

src_compile() {

	cd ${S}/wminet

	emake || die "parallel make failed"

}

src_install() {

	cd ${S}/wminet

	dobin wminet

	insinto /etc
	insopts -m 644
	doins wminetrc

	insinto /etc/skel
	insopts -m 600
	newins wminetrc .wminetrc

}
