# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmon+smp/wmmon+smp-1.0-r1.ebuild,v 1.2 2002/10/04 06:45:58 vapier Exp $

S=${WORKDIR}/wmmon.app
S2=${S}/wmmon
DESCRIPTION="Dockapp CPU monitor resembling Xosview, support for smp"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/wmmon+smp.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_compile() {
	cd ${S2}
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe ${S2}/wmmon
	dodoc ${S}/README ${S}/COPYING ${S}/INSTALL
}
