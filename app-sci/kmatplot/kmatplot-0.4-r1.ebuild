# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/kmatplot/kmatplot-0.4-r1.ebuild,v 1.1 2003/02/03 21:13:55 hannes Exp $

PATCHES="${FILESDIR}/${P}-gentoo.patch
	${FILESDIR}/${P}-inline.patch
	${FILESDIR}/${P}-gentoo2.patch
	${FILESDIR}/${P}-kmatplotrc.patch"

inherit kde-base
need-kde 3

DESCRIPTION="KMatplot is a gnuplot-like tool for plotting data sets in either two or three dimensions."
LICENSE="GPL-2"
HOMEPAGE="http://kmatplot.sourceforge.net/"
SRC_URI="http://kmatplot.sourceforge.net/${P}.tar.gz"
IUSE=""
KEYWORDS="x86"
