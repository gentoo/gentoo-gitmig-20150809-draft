# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-trayicon/synce-trayicon-0.11.ebuild,v 1.3 2009/05/10 18:28:51 mescalinum Exp $

inherit eutils subversion gnome2

DESCRIPTION="SynCE - Gnome trayicon"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="sys-apps/dbus
		dev-libs/dbus-glib
		>=dev-libs/glib-2.0
		>=x11-libs/gtk+-2.0
		gnome-base/libgnome
		gnome-base/libgnomeui
		gnome-base/libgtop
		gnome-base/libglade
		gnome-base/gnome-keyring
		~app-pda/synce-libsynce-0.11.1
		~app-pda/synce-librra-0.11.1
		~app-pda/synce-librapi2-0.11.1"
DEPEND="${RDEPEND}
		gnome-base/gnome-common"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	# Force using automake 1.9
	epatch "${FILESDIR}"/automake-1.9.patch
}

src_compile() {
	# gnome-common < 2.18.0 hack
	touch COPYING
	touch INSTALL
	./autogen.sh --prefix=/usr
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
