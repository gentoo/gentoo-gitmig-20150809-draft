# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/knights/knights-0.6.ebuild,v 1.16 2006/05/31 15:47:21 flameeyes Exp $

ARTS_REQUIRED="yes"
inherit eutils kde

THEME=${PN}-themepack-0.5.9
DESCRIPTION="KDE Chess Interface"
HOMEPAGE="http://knights.sourceforge.net/"
SRC_URI="mirror://sourceforge/knights/${P}.tar.gz
	mirror://sourceforge/knights/${THEME}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

# need-kde isn't smart enough yet so we have to set both *DEPEND right now
RDEPEND="|| ( kde-base/kdebase-kioslaves kde-base/kdebase )"

need-kde 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gcc34.patch"
}

src_compile() {
	myconf="--disable-dependency-tracking"

	kde_src_compile
}

src_install() {
	kde_src_install

	cd ../${PN}-themepack || die "Themes seem to be missing."
	insinto /usr/share/apps/knights/themes/
	doins *.tar.gz || die "doins failed"
}
