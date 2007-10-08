# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-gnome-platform/guile-gnome-platform-2.15.92.ebuild,v 1.2 2007/10/08 15:48:15 calchan Exp $

inherit eutils autotools multilib

DESCRIPTION="Guile Scheme code that wraps the GNOME developer platform"
HOMEPAGE="http://www.gnu.org/software/guile-gnome/"
SRC_URI="http://ftp.gnu.org/pub/gnu/guile-gnome/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND=">=dev-scheme/guile-1.6.4
	>=dev-libs/g-wrap-1.9.8
	dev-scheme/guile-cairo
	dev-libs/atk
	gnome-base/libbonobo
	gnome-base/orbit
	gnome-base/gconf
	>=dev-libs/glib-2.4
	>=gnome-base/gnome-vfs-2.8
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2
	gnome-base/libgnomecanvas
	>=gnome-base/libgnomeui-2.8
	x11-libs/pango"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-add-atk-overrides.patch
	pushd cairo
	epatch "${FILESDIR}"/${PV}-add-cairo-fix-from-bzr.patch
	popd
	eautoreconf
}

src_compile() {
	econf --disable-Werror || die "configure failed"
	emake \
		guilegnomedir=/usr/share/guile/site \
		guilegnomelibdir=/usr/$(get_libdir) \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		guilegnomedir=/usr/share/guile/site \
		guilegnomelibdir=/usr/$(get_libdir) \
		install \
		|| die "install failed"
}
