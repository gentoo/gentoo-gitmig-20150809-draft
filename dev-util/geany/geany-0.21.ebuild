# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/geany/geany-0.21.ebuild,v 1.7 2012/05/04 17:51:43 jdhore Exp $

EAPI=4
inherit eutils gnome2-utils

LANGS="ast be bg ca cs de el en_GB es fi fr gl hu it ja kk ko lb nl pl pt pt_BR ro ru sl sv tr uk vi zh_CN ZH_TW"
NOSHORTLANGS="en_GB zh_CN zh_TW"

DESCRIPTION="GTK+ based fast and lightweight IDE"
HOMEPAGE="http://www.geany.org"
SRC_URI="http://download.geany.org/${P}.tar.bz2"

LICENSE="GPL-2 Scintilla"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="+vte"

RDEPEND=">=x11-libs/gtk+-2.12:2
	>=dev-libs/glib-2.16:2
	vte? ( x11-libs/vte:0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	strip-linguas ${LANGS}
}

src_prepare() {
	# Syntax highlighting for Portage
	sed -i -e "s:*.sh;:*.sh;*.ebuild;*.eclass;:" \
		data/filetype_extensions.conf || die
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable vte)
}

src_install() {
	emake DESTDIR="${D}" DOCDIR="${ED}/usr/share/doc/${PF}" install || die
	rm -f "${ED}"/usr/share/doc/${PF}/{COPYING,GPL-2,ScintillaLicense.txt}
	find "${ED}" -type f -name '*.la' -delete
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
