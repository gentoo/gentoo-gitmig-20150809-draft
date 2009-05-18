# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/wp_tray/wp_tray-0.5.5.ebuild,v 1.3 2009/05/18 15:17:01 mr_bones_ Exp $

inherit gnome2 multilib eutils

DESCRIPTION="Wallpaper Manager for the Gnome Desktop"
HOMEPAGE="http://planetearthworm.com/projects/wp_tray"

SRC_URI="http://planetearthworm.com/projects/${PN}/files/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	dev-cpp/libgnomeuimm
	dev-cpp/libxmlpp"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-libs/boost"

src_compile() {
	local myconf

	myconf="${myconf} --with-boostfilesystem=/usr/$(get_libdir)/libboost_filesystem.so"
	myconf="${myconf} --with-boostregex=/usr/$(get_libdir)/libboost_regex.so"

	econf ${myconf} || die "Configure failure"
	emake || die "Make failure"
}

src_install() {
	addpredict /root/.gconf
	gnome2_src_install
}

DOCS="AUTHORS ChangeLog INSTALL NEWS README*"
