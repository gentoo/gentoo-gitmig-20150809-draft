# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/zim/zim-0.28.ebuild,v 1.3 2011/03/02 19:22:25 signals Exp $

EAPI=2
inherit eutils fdo-mime perl-module

MY_P=${P/z/Z}

DESCRIPTION="A desktop wiki"
HOMEPAGE="http://zim-wiki.org/"
SRC_URI="http://www.zim-wiki.org/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex screenshot spell test"

COMMON_DEPEND=">=dev-lang/perl-5.8
	x11-libs/gtk+:2
	virtual/perl-Storable
	virtual/perl-IO
	virtual/perl-File-Spec
	virtual/perl-Test-Simple
	>=dev-perl/File-BaseDir-0.03
	>=dev-perl/File-MimeInfo-0.12
	>=dev-perl/File-DesktopEntry-0.03
	>=dev-perl/gtk2-perl-1.040
	x11-misc/xdg-utils"
RDEPEND="${COMMON_DEPEND}
	latex? ( virtual/latex-base app-text/dvipng )
	screenshot? ( media-gfx/scrot )
	spell? ( dev-perl/gtk2-spell )"
DEPEND="${COMMON_DEPEND}
	dev-perl/extutils-pkgconfig
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Harness )"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}/${P}-disable-updates.patch" )

src_install() {
	doicon share/pixmaps/zim.png
	perl-module_src_install
}

pkg_postinst() {
	perl-module_pkg_postinst
	fdo-mime_desktop_database_update
	xdg-icon-resource install --context mimetypes --size 64 \
		"${ROOT}/usr/share/pixmaps/zim.png" \
		application-x-zim-notebook || die "xdg-icon-resource install failed"
}

pkg_postrm() {
	perl-module_pkg_postrm
	fdo-mime_desktop_database_update
	xdg-icon-resource uninstall --context mimetypes --size 64 \
		application-x-zim-notebook || die "xdg-icon-resource uninstall failed"

}
