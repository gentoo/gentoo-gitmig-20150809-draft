# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/compizconfig-python/compizconfig-python-0.7.8.ebuild,v 1.3 2008/11/15 01:59:20 jmbsvicetto Exp $

DESCRIPTION="Compizconfig Python Bindings"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-lang/python-2.4
	>=dev-libs/glib-2.6
	dev-python/pyrex
	~x11-libs/libcompizconfig-${PV}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
