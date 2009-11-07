# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kst/kst-1.7.0-r1.ebuild,v 1.2 2009/11/07 00:33:35 ssuominen Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde flag-o-matic

DESCRIPTION="A plotting and data viewing program for KDE."
HOMEPAGE="http://kst.kde.org/"
SRC_URI="mirror://kde/stable/apps/KDE3.x/scientific/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/readline
	sci-libs/gsl
	>=sci-libs/netcdf-3.6.1-r1"
RDEPEND="${DEPEND}"

need-kde 3.5

PATCHES=(
	"${FILESDIR}/kst-1.7.0-desktop-file.diff"
	"${FILESDIR}/kst-1.7.0-system-kjs.diff"
	)

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
	sed -e "s:KJSE_SUBDIR=js:KJSE_SUBDIR=:" -i kst/src/extensions/Makefile.am
	# automagic dependency, ensure internel lib isn't used by mistake
	echo "FAIL FOR GOOD" > "${S}"/kst/src/extensions/js/kjsembed/global.cpp
}
