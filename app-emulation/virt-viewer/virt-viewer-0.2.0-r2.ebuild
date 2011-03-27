# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-viewer/virt-viewer-0.2.0-r2.ebuild,v 1.2 2011/03/27 10:34:20 nirbheek Exp $

EAPI=2

inherit eutils

DESCRIPTION="Graphical console client for connecting to virtual machines"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nsplugin"
RDEPEND=">=x11-libs/gtk+-2.10.0:2
	>=gnome-base/libglade-2.6.0:2.0
	>=app-emulation/libvirt-0.6.0
	>=net-libs/gtk-vnc-0.3.8
	>=dev-libs/libxml2-2.6.0:2
	nsplugin? ( >=dev-libs/nspr-4.0.0
				>=net-libs/xulrunner-1.9.1:1.9 )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-xulrunner-1.9.1.patch
}

src_configure() {
	econf $(use_enable nsplugin plugin)
}

src_install() {
	emake DESTDIR="${D}" install || die
}
