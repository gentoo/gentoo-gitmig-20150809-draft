# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/pydict/pydict-0.2.5.1.ebuild,v 1.8 2004/05/31 18:17:14 vapier Exp $

DESCRIPTION="Chinese-English / English-Chinese dictionary"
HOMEPAGE="http://sourceforge.net/projects/pydict"
SRC_URI="mirror://sourceforge/pydict/pyDict-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/python
	=dev-python/pygtk-0.6*"

S="${WORKDIR}/dict"

src_install() {
	dodoc CHANGELOG README
	insinto /usr/X11R6/lib/X11/pyDict
	doins [a-z].lib yaba.xpm HELP
	if [ -d ${ROOT}/usr/share/gnome/apps/Chinese ]; then
		insinto /usr/share/gnome/apps/Chinese
		doins pyDict.desktop
	fi
	if [ -d ${ROOT}/usr/share/icons ] ; then
		insinto /usr/share/icons
		doins dict.xpm
	fi
	into /usr/X11R6
	newbin dict.py pydict
}
