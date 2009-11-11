# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kst/kst-1.1.1.ebuild,v 1.7 2009/11/11 12:11:31 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="A plotting and data viewing program for KDE."
HOMEPAGE="http://kst.kde.org/"
SRC_URI="mirror://kde/stable/apps/KDE3.x/scientific/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND="sci-libs/gsl"

need-kde 3.5

PATCHES=( "${FILESDIR}/${PN}-1.1.0-netcdf-fix.patch" )

src_unpack(){
	kde_src_unpack
	rm -f configure
	autoconf || die "autoconf failed"
}
