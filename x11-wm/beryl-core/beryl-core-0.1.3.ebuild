# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/beryl-core/beryl-core-0.1.3.ebuild,v 1.3 2006/12/21 15:10:12 corsair Exp $

inherit autotools

DESCRIPTION="Beryl window manager for AIGLX and XGL"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2
	http://releases.beryl-project.org/${PV}/beryl-mesa-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=x11-base/xorg-server-1.1.1-r1
	>=x11-libs/gtk+-2.8.0
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/startup-notification"

RDEPEND="${DEPEND}
	x11-apps/xdpyinfo"

PDEPEND="~x11-plugins/beryl-plugins-${PV}"

src_compile() {
	epatch "${FILESDIR}"/${PN}-gconf.patch
	eautoreconf

	econf --with-berylmesadir="${WORKDIR}/beryl-mesa" || die "econf failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
