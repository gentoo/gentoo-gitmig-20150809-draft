# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-unico/gtk-engines-unico-1.0.2.ebuild,v 1.7 2012/11/17 12:27:22 ssuominen Exp $

EAPI=5
inherit eutils

MY_PN=${PN/gtk-engines-}
MY_P=${MY_PN}-${PV}

DESCRIPTION="The Unico GTK+ 3.x Theming Engine"
HOMEPAGE="https://launchpad.net/unico"
SRC_URI="https://launchpad.net/${MY_PN}/${PV%.*}/${PV}/+download/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.26
	>=x11-libs/cairo-1.10[glib]
	>=x11-libs/gtk+-3.3.14:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	DOCS="AUTHORS NEWS" # ChangeLog and README are empty.
}

src_configure() {
	# $(use_enable debug) controls CPPFLAGS -D_DEBUG and -DNDEBUG but they are currently
	# unused in the code itself.
	econf \
		--disable-static \
		--disable-debug \
		--disable-maintainer-flags
}

src_install() {
	default
	prune_libtool_files --all
}
