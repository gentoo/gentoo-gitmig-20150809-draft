# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetmon/wmnetmon-0.2.ebuild,v 1.4 2004/03/26 23:10:10 aliz Exp $

IUSE=""
S=${WORKDIR}/${P}p5/
DESCRIPTION="dockapp that monitors up to 40 hosts/services and can execute something if there is a problem with any of them"
HOMEPAGE="http://freshmeat.net/projects/wmnetmon/?topic_id=876"
SRC_URI="http://www.linuks.mine.nu/dockapps/${P}p5.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_compile() {
	econf --prefix=${D}/usr/bin || die "Configure failed."
	emake || die "Make failed"
}

src_install() {
	dobin wmnetmon
	fowners root:root /usr/bin/wmnetmon
	fperms 4755 /usr/bin/wmnetmon
	dodoc README Changes wmnetmonrc
}

pkg_postinst() {
	ewarn
	ewarn "Before starting up wmnetmon, you must create a .wmnetmonrc in your home folder."
	ewarn "Look at the sample wmnetmonrc.gz file in /usr/share/doc/${P}/."
	ewarn
}
