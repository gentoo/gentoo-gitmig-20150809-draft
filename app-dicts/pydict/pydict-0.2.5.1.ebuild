# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/pydict/pydict-0.2.5.1.ebuild,v 1.4 2003/06/29 17:14:26 aliz Exp $

DESCRIPTION="Chinese-English / English-Chinese dictionary"
HOMEPAGE="http://sourceforge.net/projects/pydict"
SRC_URI="mirror://sourceforge/${PN}/pyDict-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/python
        =dev-python/pygtk-0.6*"

S="${WORKDIR}/dict"

src_install() {
	dodoc CHANGELOG README COPYING
	insinto /usr/X11R6/lib/X11/pyDict
	doins [a-z].lib yaba.xpm HELP
	if [ -d /usr/share/gnome/apps/Chinese ]; then
		insinto /usr/share/gnome/apps/Chinese
		doins pyDict.desktop
	fi
	if [ -d /usr/share/icons ]; then
		insinto /usr/share/icons
		doins dict.xpm
	fi
	into /usr/X11R6
	newbin dict.py pydict
}
