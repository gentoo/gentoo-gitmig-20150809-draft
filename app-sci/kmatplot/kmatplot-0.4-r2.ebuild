# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kmatplot/kmatplot-0.4-r2.ebuild,v 1.3 2003/09/27 19:10:53 lanius Exp $

PATCHES="${FILESDIR}/${P}-gentoo.patch
	${FILESDIR}/${P}-inline.patch
	${FILESDIR}/${P}-gentoo2.patch
	${FILESDIR}/${P}-kmatplotrc.patch
	${FILESDIR}/${P}-octave.patch"

inherit kde
need-kde 3

DESCRIPTION="gnuplot-like tool for plotting data sets in either two or three dimensions"
HOMEPAGE="http://kmatplot.sourceforge.net/"
SRC_URI="http://kmatplot.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=app-sci/octave-2.1
	>=app-sci/scilab-2.6"
