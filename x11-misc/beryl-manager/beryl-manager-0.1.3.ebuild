# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/beryl-manager/beryl-manager-0.1.3.ebuild,v 1.2 2006/12/21 15:19:09 corsair Exp $

DESCRIPTION="Beryl Window Decorator Manager"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.8.0"

RDEPEND="${DEPEND}
	x11-apps/xlsclients
	x11-apps/xvinfo"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
