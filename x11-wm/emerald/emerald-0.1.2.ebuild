# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/emerald/emerald-0.1.2.ebuild,v 1.1 2006/11/15 04:05:42 tsunam Exp $

inherit gnome2 

DESCRIPTION="Beryl Window Decorator"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
WANT_AUTOMAKE=1.9

PDEPEND="=x11-misc/emerald-themes-0.1.2"

DEPEND=">=x11-libs/gtk+-2.8.0
	>=x11-libs/libwnck-2.14.2
	=x11-wm/beryl-core-0.1.2"


src_compile() {
	glib-gettextize --copy --force || die
	intltoolize --automake --copy --force || die

	gnome2_src_compile --disable-mime-update
}
