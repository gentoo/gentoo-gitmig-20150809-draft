# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-viewer/virt-viewer-0.0.3.ebuild,v 1.2 2009/01/19 11:29:15 armin76 Exp $

DESCRIPTION="Graphical console client for connecting to virtual machines"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=app-emulation/libvirt-0.3.1
	>=net-libs/gtk-vnc-0.3.4
	dev-lang/perl
	dev-libs/libxml2"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
}
