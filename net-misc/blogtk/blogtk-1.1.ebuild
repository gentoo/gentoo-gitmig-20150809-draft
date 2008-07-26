# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/blogtk/blogtk-1.1.ebuild,v 1.6 2008/07/26 22:48:58 eva Exp $

inherit eutils fdo-mime python

DESCRIPTION="GTK Blog - post entries to your blog"
HOMEPAGE="http://blogtk.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/BloGTK-${PV}.tar.bz2"
RESTRICT="mirror"
S="${WORKDIR}/BloGTK-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.0.0
	>=gnome-base/gconf-2.2.0
	>=dev-python/gnome-python-2
	dev-python/gnome-python-extras
	amd64? ( >=dev-python/gnome-python-2.6.1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-destdir.patch"

	# Respect multilib
	sed -i "s:lib/blogtk:$(get_libdir)/blogtk:g" Makefile || die "sed failed"
}

src_compile() {
	return
}

src_install() {
	emake DESTDIR="${D}" install || die "Unable to compile blogtk"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	python_mod_optimize /usr/$(get_libdir)/blogtk
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	python_mod_cleanup /usr/$(get_libdir)/blogtk
}
