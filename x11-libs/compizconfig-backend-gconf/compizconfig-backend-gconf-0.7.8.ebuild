# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/compizconfig-backend-gconf/compizconfig-backend-gconf-0.7.8.ebuild,v 1.3 2008/11/15 02:07:08 jmbsvicetto Exp $

DESCRIPTION="Compizconfig Gconf Backend"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=gnome-base/gconf-2.0
	~x11-libs/libcompizconfig-${PV}
	~x11-wm/compiz-${PV}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
