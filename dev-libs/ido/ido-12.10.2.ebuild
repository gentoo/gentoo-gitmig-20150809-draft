# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ido/ido-12.10.2.ebuild,v 1.1 2014/03/15 13:50:18 ssuominen Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Indicator Display Objects -library from the ayatana project"
HOMEPAGE="http://launchpad.net/ido"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.32
	>=x11-libs/gtk+-3.4:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS"

src_prepare() {
	sed -i -e 's:-Werror::' configure.ac src/Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	default
	prune_libtool_files --all
}
