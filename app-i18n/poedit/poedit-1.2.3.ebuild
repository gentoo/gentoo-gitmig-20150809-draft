# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.2.3.ebuild,v 1.4 2004/12/08 00:00:12 pythonhead Exp $

inherit eutils kde wxwidgets

IUSE="gtk2 unicode"
DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
SRC_URI="mirror://sourceforge/poedit/${P}.tar.bz2"
HOMEPAGE="http://poedit.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc"

DEPEND="<x11-libs/wxGTK-2.5
	app-arch/zip
	>=sys-libs/db-3"

pkg_setup() {
	if use unicode && ! use gtk2; then
		die "You must put gtk2 in your USE if you want unicode."
	fi
}

src_compile() {
	if use unicode ; then
		need-wxwidgets unicode || die "You need to emerge wxGTK with unicode in your USE"
	elif ! use gtk2 ; then
		need-wxwidgets gtk || die "You need to emerge wxGTK with gtk in your USE"
	else
		need-wxwidgets gtk2 || die "You need to emerge wxGTK with gtk2 in your USE"
	fi
	#Maybe WX_CONFIG_NAME should be added to wxwidgets.eclass
	export WX_CONFIG_NAME=${WX_CONFIG}
	econf || die
	emake || die
}

src_install () {

	einstall \
		datadir=${D}/usr/share \
		GNOME_DATA_DIR=${D}/usr/share \
		KDE_DATA_DIR=${D}/${KDEDIR-/usr}/share || die

	dodoc AUTHORS LICENSE NEWS README TODO
}
