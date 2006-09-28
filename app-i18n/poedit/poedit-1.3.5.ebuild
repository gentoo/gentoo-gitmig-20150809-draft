# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.3.5.ebuild,v 1.1 2006/09/28 11:55:25 leio Exp $

inherit eutils wxwidgets flag-o-matic

DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
SRC_URI="mirror://sourceforge/poedit/${P}.tar.gz"
HOMEPAGE="http://poedit.sourceforge.net/"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="spell"

DEPEND=">x11-libs/wxGTK-2.6
	>=sys-libs/db-3
	spell? ( >=app-text/gtkspell-2.0.0 )"

pkg_setup() {
	export WX_GTK_VER="2.6"
	need-wxwidgets unicode
}

src_compile() {
	append-flags -fno-strict-aliasing

	econf \
		$(use_enable spell spellchecking) \
		|| die "Configure failed!"
	emake || die "Build failed!"
}

src_install () {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS NEWS README TODO
}
