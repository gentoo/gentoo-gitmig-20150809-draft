# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.2-r2.ebuild,v 1.3 2003/02/13 09:17:06 vapier Exp $
inherit kde-base flag-o-matic

filter-flags "-fomit-frame-pointer"

need-kde 3

DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/$P/src/$P.tar.bz2"

KEYWORDS="x86 ppc"

DEPEND="$DEPEND
	>=dev-lang/python-2.2.1
	>=media-libs/libart_lgpl-2.3.9
	>=media-gfx/imagemagick-5.4.5"

export LIBPYTHON="`python-config --libs`"
export LIBPYTHON="${LIBPYTHON//-L \/usr\/lib\/python2.2\/config}"

need-automake 1.5
need-autoconf 2.5

# 1st patch: fix bug #7893 - kde bug #47146.
# 2nd patch: fix bug #11058
# patches are from koffice cvs - stable tree
PATCHES="$FILESDIR/$P-connectortool.diff $FILESDIR/$P-kspread_cell.diff"
