# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/koncd/koncd-1.0_rc1.ebuild,v 1.21 2003/06/25 22:36:51 vapier Exp $

inherit kde-base

need-kde 2.2

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A KDE frontend to cdr apps; very powerful"
SRC_URI="http://www.koncd.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.koncd.org/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"

DEPEND="${DEPEND}
	>=app-cdr/cdrtools-1.11
	>=app-cdr/cdrdao-1.1.5
	>=media-sound/mpg123-0.59r"
