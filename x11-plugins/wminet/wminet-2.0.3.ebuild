# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wminet/wminet-2.0.3.ebuild,v 1.1 2002/10/03 17:42:44 raker Exp $

S="${WORKDIR}/${PN}.app"

DESCRIPTION="dockapp that displays useful server statistics"
HOMEPAGE="http://www.neotokyo.org/illusion/dock_apps.html"
SRC_URI="http://www.neotokyo.org/illusion/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"
RDEPEND="${DEPEND}"

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
