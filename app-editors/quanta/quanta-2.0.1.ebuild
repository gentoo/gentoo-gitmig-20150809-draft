# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/quanta/quanta-2.0.1.ebuild,v 1.18 2003/06/25 22:41:05 vapier Exp $

inherit kde-base

need-kde 2.1

DESCRIPTION="Quanta - HTML editor for KDE2"
SRC_URI="mirror://sourceforge/quanta/${P}.tar.bz2
	 mirror://sourceforge/quanta/css.tar.bz2
	 mirror://sourceforge/quanta/html.tar.bz2
	 mirror://sourceforge/quanta/javascript.tar.bz2
	 mirror://sourceforge/quanta/php.tar.bz2"
HOMEPAGE="http://quanta.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="sys-apps/tar
	sys-apps/bzip2"
RDEPEND=""

src_install() {
	kde_src_install
	
	dodir ${PREFIX}/share/apps/quanta/doc/
	for x in css html javascript php ; do
		cp -a ${WORKDIR}/${x}/*.docrc ${WORKDIR}/${x}/${x} ${D}/${PREFIX}/share/apps/quanta/doc/
	done
}
