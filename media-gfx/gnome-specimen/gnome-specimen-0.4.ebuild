# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-specimen/gnome-specimen-0.4.ebuild,v 1.2 2010/05/31 15:06:58 arfrever Exp $

GCONF_DEBUG=no

inherit gnome2 multilib python

DESCRIPTION="Font preview application"
HOMEPAGE="http://uwstopia.nl"
SRC_URI="http://uwstopia.nl/geek/projects/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	dev-python/gnome-python"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	ln -nfs $(type -P true) py-compile || die "ln failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/specimen
	gnome2_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/specimen
	gnome2_pkg_postrm
}
