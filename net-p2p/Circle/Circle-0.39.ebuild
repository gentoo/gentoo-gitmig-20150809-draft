# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/Circle/Circle-0.39.ebuild,v 1.2 2004/04/14 09:10:38 dholm Exp $

inherit python

DESCRIPTION="The Circle messaging and file sharing system"
HOMEPAGE="http://thecircle.org.au/"
SRC_URI="http://thecircle.org.au/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="oggvorbis gnome"

DEPEND="virtual/python
	>=dev-python/pygtk-1.99.14
	>=gtk+-2
	oggvorbis? ( dev-python/pyogg
		dev-python/pyvorbis )
	gnome? ( dev-python/gnome-python )"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	python_version
	exeinto /usr/bin/
	doexe circle
	exeinto /usr/lib/apt/methods/
	doexe cftp chttp
	insinto /usr/lib/python${PYVER}/site-packages/circlelib/
	doins circlelib/*.py*
	doins circlelib/*.xpm
	insinto /usr/share/pixmaps/
	doins circle-icon.png
	if [ `use gnome` ] ; then
		insinto /usr/share/gnome/apps/Internet/
		doins circle.desktop
	fi
	dohtml circlelib/*.html
	dodoc NEWS PKG-INFO README
}
