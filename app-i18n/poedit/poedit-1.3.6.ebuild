# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.3.6.ebuild,v 1.2 2006/12/29 15:14:19 dirtyepic Exp $

WX_GTK_VER="2.6"

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

src_compile() {
	append-flags -fno-strict-aliasing
	need-wxwidgets unicode

	econf \
		$(use_enable spell spellchecking) \
		--with-wx-config="${WX_CONFIG}" \
		|| die "Configure failed!"
	emake || die "Build failed!"
}

src_install () {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS NEWS README TODO
}
