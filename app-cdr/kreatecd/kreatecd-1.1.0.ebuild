# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kreatecd/kreatecd-1.1.0.ebuild,v 1.17 2003/06/25 22:38:23 vapier Exp $

inherit kde-base

need-kde 2.2

DESCRIPTION="KreateCD 1.1.0"
SRC_URI="mirror://sourceforge/kreatecd/${P}.tar.bz2"
HOMEPAGE="http://www.kreatecd.de/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="${DEPEND}
	>=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8
	>=app-cdr/cdrtools-1.11"
