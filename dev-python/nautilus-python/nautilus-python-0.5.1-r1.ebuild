# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nautilus-python/nautilus-python-0.5.1-r1.ebuild,v 1.1 2009/08/20 08:25:24 pva Exp $

EAPI="2"

inherit gnome.org eutils

DESCRIPTION="Python bindings for the Nautilus file manager"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pygtk-2.8
	>=dev-python/gnome-python-2.12
	>=gnome-base/nautilus-2.6
	>=gnome-base/eel-2.6"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-CVE-2009-0317.patch"
	epatch "${FILESDIR}/${P}-submenu-example.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die
	mv "${D}"/usr/share/doc/{${PN},${PF}}
	dodoc AUTHORS ChangeLog NEWS || die
}
