# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-gnome-platform/guile-gnome-platform-2.16.1.ebuild,v 1.5 2009/12/11 22:02:53 ulm Exp $

inherit eutils multilib

DESCRIPTION="Guile Scheme code that wraps the GNOME developer platform"
HOMEPAGE="http://www.gnu.org/software/guile-gnome"
SRC_URI="http://ftp.gnu.org/pub/gnu/guile-gnome/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-scheme/guile-1.6.4
	>=dev-libs/g-wrap-1.9.11
	dev-scheme/guile-cairo
	dev-libs/atk
	gnome-base/libbonobo
	gnome-base/orbit
	>=gnome-base/gconf-2.18
	>=dev-libs/glib-2.10
	>=gnome-base/gnome-vfs-2.16
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2.6
	>=gnome-base/libgnomecanvas-2.14
	>=gnome-base/libgnomeui-2.16
	>=x11-libs/pango-1.14
	dev-scheme/guile-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#needs guile with networking
RESTRICT=test

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-conflicting-types.patch"
}

src_compile() {
	econf --disable-Werror
	emake -j1 guilegnomedir=/usr/share/guile/site \
		guilegnomelibdir=/usr/$(get_libdir) || die "emake failed."
}

src_install() {
	emake -j1 DESTDIR="${D}" \
		guilegnomedir=/usr/share/guile/site \
		guilegnomelibdir=/usr/$(get_libdir) \
		install || die "emake install failed."
}
