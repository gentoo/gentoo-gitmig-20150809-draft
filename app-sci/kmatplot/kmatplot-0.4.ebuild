# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/kmatplot/kmatplot-0.4.ebuild,v 1.4 2003/02/02 22:41:34 hannes Exp $

PATCHES="${FILESDIR}/${P}-gentoo.patch
	${FILESDIR}/${P}-inline.patch
	${FILESDIR}/${P}-gentoo2.patch"

inherit kde-base
need-kde 3

DESCRIPTION="KMatplot is a gnuplot-like tool for plotting data sets in either two or three dimensions."
LICENSE="GPL-2"
HOMEPAGE="http://kmatplot.sourceforge.net/"
SRC_URI="http://kmatplot.sourceforge.net/${P}.tar.gz"
IUSE=""
KEYWORDS="x86"
