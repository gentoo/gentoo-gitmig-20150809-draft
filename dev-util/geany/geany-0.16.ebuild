# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/geany/geany-0.16.ebuild,v 1.2 2009/04/30 13:51:08 volkmar Exp $

EAPI=1

inherit gnome2-utils

DESCRIPTION="GTK+ based fast and lightweight IDE."
HOMEPAGE="http://geany.uvena.de"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	http://files.uvena.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 Scintilla"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86 ~x86-fbsd"
IUSE="+vte"

RDEPEND=">=x11-libs/gtk+-2.10
	vte? ( x11-libs/vte )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	# Syntax highlighting for Portage.
	sed -i -e "s:*.sh;:*.sh;*.ebuild;*.eclass;:" \
		"${S}"/data/filetype_extensions.conf || die "sed failed."
}

src_compile() {
	econf --disable-dependency-tracking --enable-the-force \
		$(use_enable vte)
	emake || die "emake failed."
}

pkg_preinst() {
	gnome2_icon_savelist
}

src_install() {
	emake DESTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" \
		install || die "emake install failed."
	rm -f "${D}"/usr/share/doc/${PF}/{COPYING,GPL-2,ScintillaLicense.txt}
	prepalldocs
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
