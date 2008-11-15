# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/compiz-bcop/compiz-bcop-0.7.8.ebuild,v 1.3 2008/11/15 02:03:52 jmbsvicetto Exp $

DESCRIPTION="Compiz Option code Generator"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libxslt"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
