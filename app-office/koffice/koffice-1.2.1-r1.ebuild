# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.2.1-r1.ebuild,v 1.15 2004/06/29 11:42:09 carlo Exp $
inherit kde flag-o-matic

filter-flags "-fomit-frame-pointer"

DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/$P/src/$P.tar.bz2"

KEYWORDS="x86 ppc sparc alpha"

IUSE=""
SLOT="0"

DEPEND=">=dev-lang/python-2.2.1
	>=media-libs/libart_lgpl-2.3.9
	>=media-gfx/imagemagick-5.4.5"
need-kde 3

PATCHES="$FILESDIR/${P}-kword-crashes.diff"

src_compile() {
	export LIBPYTHON="`python-config --libs`"
	export LIBPYTHON="${LIBPYTHON//-L \/usr\/lib\/python2.2\/config}"
	kde_src_compile
}
export WANT_AUTOCONF=2.5
export WANT_AUTOMAKE=1.5

