# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-2.1_beta3.ebuild,v 1.3 2009/12/15 19:33:23 ranger Exp $

EAPI=2

KDE_DOC_DIRS="doc"
inherit kde4-base

MY_P=${P/_beta/b}

DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ppc64 ~x86"
SLOT="4"
IUSE="debug handbook +pdf +png"

RDEPEND="
	|| (
		>=kde-base/okular-${KDE_MINIMAL}[pdf?,ps]
		app-text/acroread
	)
	virtual/latex-base
	virtual/tex-base
	pdf? (
		app-text/dvipdfmx
		app-text/ghostscript-gpl
	)
	png? (
		app-text/dvipng
		media-gfx/imagemagick[png]
	)
"

S=${WORKDIR}/${MY_P}

src_prepare() {
	kde4-base_src_prepare
	# remove handbook
	sed -i \
		-e "/ADD_CUSTOM_TARGET/s/^/#DONOTINSTALL /" \
		CMakeLists.txt || die
	rm -rf doc/
}

src_configure() {
	mycmakeargs="
		-DKILE_VERSION=${PF/${PN}-/}
	"

	kde4-base_src_configure
}
