# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/quanta/quanta-3.0_pre2.ebuild,v 1.1 2002/09/16 16:23:48 verwilst Exp $
inherit kde-base

need-kde 3

DESCRIPTION="A superb web development tool for KDE 3.x"

SRC_URI="mirror://sourceforge/quanta/quanta-3.0pr2a.tar.bz2
	 mirror://sourceforge/quanta/css.tar.bz2
	 mirror://sourceforge/quanta/html.tar.bz2
	 mirror://sourceforge/quanta/javascript.tar.bz2
	 mirror://sourceforge/quanta/php.tar.bz2"

HOMEPAGE="http://quanta.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86"

S="${WORKDIR}/quanta-3.0pr2a"

src_install() {
	
	kde_src_install
	
	dodir ${PREFIX}/share/apps/quanta/doc/
	for x in css html javascript php; do
	cp -a ${WORKDIR}/${x}/*.docrc ${WORKDIR}/${x}/${x} ${D}/${PREFIX}/share/apps/quanta/doc/
	done
	
}
