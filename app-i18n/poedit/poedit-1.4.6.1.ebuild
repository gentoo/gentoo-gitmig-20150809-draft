# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.4.6.1.ebuild,v 1.5 2010/07/14 16:47:48 jer Exp $

EAPI=2
WX_GTK_VER=2.8

inherit eutils wxwidgets flag-o-matic fdo-mime

DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
SRC_URI="mirror://sourceforge/poedit/${P}.tar.gz"
HOMEPAGE="http://poedit.sourceforge.net/"

SLOT="0"
LICENSE="MIT"
KEYWORDS="amd64 hppa ~ppc sparc x86"
IUSE="spell"

DEPEND="x11-libs/wxGTK:2.8[X]
	>=sys-libs/db-3.1
	spell? ( >=app-text/gtkspell-2.0.0 )"

RDEPEND=${DEPEND}

src_configure() {
	append-flags -fno-strict-aliasing

	econf \
		$(use_enable spell spellchecking) \
		|| die "Configure failed!"
}

src_install () {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS NEWS README TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
