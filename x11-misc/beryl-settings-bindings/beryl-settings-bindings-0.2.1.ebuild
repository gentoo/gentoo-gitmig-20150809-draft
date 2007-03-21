# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/beryl-settings-bindings/beryl-settings-bindings-0.2.1.ebuild,v 1.1 2007/03/21 02:52:28 tsunam Exp $

DESCRIPTION="Beryl Window Decorator Settings Bindings"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-libs/glib-2.6.0
	~x11-wm/beryl-core-${PV}
	>=dev-lang/python-2.4
	dev-python/pyrex"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
