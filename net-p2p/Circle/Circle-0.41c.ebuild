# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/Circle/Circle-0.41c.ebuild,v 1.5 2010/04/11 18:11:47 sochotnicky Exp $

inherit python

DESCRIPTION="The Circle messaging and file sharing system"
HOMEPAGE="http://thecircle.org.au/"
SRC_URI="http://thecircle.org.au/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="vorbis gnome"

DEPEND="virtual/python
	>=dev-python/pygtk-1.99.14
	>=x11-libs/gtk+-2
	vorbis? ( dev-python/pyogg
		dev-python/pyvorbis )
	gnome? ( dev-python/gnome-python )"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	exeinto /usr/bin/
	doexe circle
	insinto ${python_get_sitedir}/circlelib
	doins circlelib/*.py
	insinto ${python_get_sitedir}/circlelib/pixmaps
	doins circlelib/pixmaps/*
	insinto ${python_get_sitedir}/circlelib/crypto/
	doins circlelib/crypto/*
	insinto ${python_get_sitedir}/circlelib/ui_gtk/
	doins circlelib/ui_gtk/*
	insinto ${python_get_sitedir}/circlelib/ui_http/
	doins circlelib/ui_http/*
	insinto ${python_get_sitedir}/circlelib/ui_text/
	doins circlelib/ui_text/*
	insinto /usr/share/pixmaps/
	doins circle-icon.png
	if use gnome ; then
		insinto /usr/share/gnome/apps/Internet/
		doins circle.desktop
	fi
	dohtml circlelib/html/*.html
	dodoc NEWS PKG-INFO README
}
