# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zim/zim-0.23.ebuild,v 1.2 2008/04/25 18:19:55 drac Exp $

EAPI=1

inherit fdo-mime perl-module

MY_P=${P/z/Z}

DESCRIPTION="A desktop wiki"
HOMEPAGE="http://pardus-larus.student.utwente.nl/~pardus/projects/zim"
SRC_URI="http://pardus-larus.student.utwente.nl/~pardus/downloads/Zim/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex screenshot spell +trayicon"

RDEPEND=">=dev-lang/perl-5.8
	>=x11-libs/gtk+-2.4
	virtual/perl-Storable
	virtual/perl-File-Spec
	>=dev-perl/File-BaseDir-0.03
	>=dev-perl/File-MimeInfo-0.12
	>=dev-perl/File-DesktopEntry-0.03
	>=dev-perl/gtk2-perl-1.040
	latex? ( virtual/latex-base app-text/dvipng )
	screenshot? ( media-gfx/scrot )
	spell? ( dev-perl/gtk2-spell )
	trayicon? ( dev-perl/gtk2-trayicon )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}/${PN}-0.20-disable-update-desktop-database.patch" )

pkg_postinst() {
	perl-module_pkg_postinst
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	perl-module_pkg_postrm
	fdo-mime_desktop_database_update
}
