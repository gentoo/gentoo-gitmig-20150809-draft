# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-viewer/virt-viewer-0.2.0-r1.ebuild,v 1.1 2009/12/10 17:28:00 flameeyes Exp $

EAPI=2

DESCRIPTION="Graphical console client for connecting to virtual machines"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nsplugin"
RDEPEND=">=x11-libs/gtk+-2.10.0
	>=gnome-base/libglade-2.6.0
	>=app-emulation/libvirt-0.6.0
	>=net-libs/gtk-vnc-0.3.8
	>=dev-libs/libxml2-2.6.0
	nsplugin? ( >=dev-libs/nspr-4.0.0
				>=net-libs/xulrunner-1.9.0 )"
DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_enable nsplugin plugin)
}

src_install() {
	emake DESTDIR="${D}" install || die
}
