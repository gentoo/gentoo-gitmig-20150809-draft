# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/Circle/Circle-0.41c.ebuild,v 1.1 2004/07/22 04:17:32 squinky86 Exp $

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
	insinto /usr/lib/python${PYVER}/site-packages/circlelib/
	doins circlelib/*.py
	insinto /usr/lib/python${PYVER}/site-packages/circlelib/pixmaps/
	doins circlelib/pixmaps/*
	insinto /usr/lib/python${PYVER}/site-packages/circlelib/crypto/
	doins circlelib/crypto/*
	insinto /usr/lib/python${PYVER}/site-packages/circlelib/ui_gtk/
	doins circlelib/ui_gtk/*
	insinto /usr/lib/python${PYVER}/site-packages/circlelib/ui_http/
	doins circlelib/ui_http/*
	insinto /usr/lib/python${PYVER}/site-packages/circlelib/ui_text/
	doins circlelib/ui_text/*
	insinto /usr/share/pixmaps/
	doins circle-icon.png
	if use gnome ; then
		insinto /usr/share/gnome/apps/Internet/
		doins circle.desktop
	fi
	dohtml circlelib/*.html
	dodoc NEWS PKG-INFO README
}
