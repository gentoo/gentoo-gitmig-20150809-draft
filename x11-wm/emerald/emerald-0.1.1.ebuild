# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/emerald/emerald-0.1.1.ebuild,v 1.2 2006/10/24 02:23:55 tsunam Exp $

inherit gnome2 autotools

DESCRIPTION="Beryl Window Decorator"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://distfiles.gentoo-xeffects.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

PDEPEND="x11-misc/emerald-themes"

DEPEND=">=x11-libs/gtk+-2.8.0
	>=x11-libs/libwnck-2.14.2
	x11-wm/beryl-core"

S="${WORKDIR}/${PN}"

src_compile() {
	eautoreconf || die "eautoreconf failed"
	glib-gettextize --copy --force || die
	intltoolize --automake --copy --force || die

	gnome2_src_compile --disable-mime-update
}
