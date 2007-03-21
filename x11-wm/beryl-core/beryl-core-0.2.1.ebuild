# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/beryl-core/beryl-core-0.2.1.ebuild,v 1.1 2007/03/21 02:47:38 tsunam Exp $

DESCRIPTION="Beryl window manager for AIGLX and XGL"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2
	http://releases.beryl-project.org/0.1.99.2/beryl-mesa-0.1.99.2.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.1.1-r1
	>=x11-libs/gtk+-2.8.0
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/libXcomposite
	x11-libs/libXinerama
	x11-libs/startup-notification"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15
	>=dev-util/intltool-0.35
	x11-apps/xdpyinfo"

PDEPEND="~x11-plugins/beryl-plugins-${PV}"

src_compile() {
	econf \
		--enable-xgl \
		--with-berylmesadir="${WORKDIR}/beryl-mesa" || die "econf failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
