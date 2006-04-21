# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.3.4.ebuild,v 1.4 2006/04/21 04:40:04 halcy0n Exp $

inherit eutils wxwidgets

DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
SRC_URI="mirror://sourceforge/poedit/${P}.tar.gz"
HOMEPAGE="http://poedit.sourceforge.net/"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE="spell unicode"

DEPEND=">x11-libs/wxGTK-2.6
	app-arch/zip
	>=sys-libs/db-3
	spell? ( >=app-text/gtkspell-2.0.0 )"


src_compile() {
	WX_GTK_VER="2.6"
	local myconf
	use spell || myconf="${myconf} --disable-spellchecking"

	if use unicode ; then
		need-wxwidgets unicode || die "You need to emerge wxGTK with unicode in your USE"
	else
		need-wxwidgets gtk2 || die "You need to emerge wxGTK with gtk2 in your USE"
	fi
	econf ${myconf} \
		--with-wx-config=${WX_CONFIG} \
		--with-wxbase-config=${WX_CONFIG}|| die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	doicon "${S}"/src/icons/appicon/poedit.png
	domenu "${S}"/install/poedit.desktop
	dodoc AUTHORS NEWS README TODO
}
