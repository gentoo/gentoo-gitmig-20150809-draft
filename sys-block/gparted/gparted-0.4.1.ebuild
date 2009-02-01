# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/gparted/gparted-0.4.1.ebuild,v 1.3 2009/02/01 19:36:09 nixnut Exp $

inherit eutils gnome2

DESCRIPTION="Gnome Partition Editor"
HOMEPAGE="http://gparted.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="fat gnome hfs jfs kde ntfs reiserfs reiser4 xfs xfce"

common_depends=">=sys-apps/parted-1.7.1
		>=dev-cpp/gtkmm-2.8.0"

RDEPEND="${common_depends}
	gnome? ( x11-libs/gksu )
	xfce? ( x11-libs/gksu )
	kde? ( || ( kde-base/kdesu kde-base/kdebase ) )
	fat? ( sys-fs/dosfstools )
	ntfs? ( sys-fs/ntfsprogs )
	hfs? (
		sys-fs/udev
		sys-fs/hfsutils )
	jfs? ( sys-fs/jfsutils )
	reiserfs? ( sys-fs/reiserfsprogs )
	reiser4? ( sys-fs/reiser4progs )
	xfs? ( sys-fs/xfsprogs sys-fs/xfsdump )"

DEPEND="${common_depends}
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.35.5
	app-text/scrollkeeper
	app-text/gnome-doc-utils"

DOCS="AUTHORS NEWS ChangeLog README"

src_unpack() {
	gnome2_src_unpack

	# Revert upstream changes to use gksu inconditionally
	sed "s:Exec=@gksuprog@ :Exec=:" \
		-i gparted.desktop.in.in || die "sed 1 failed"
}

pkg_setup() {
	G2CONF="${G2CONF} --enable-doc --disable-scrollkeeper GKSUPROG=/bin/true"
}

src_install() {
	gnome2_src_install

	if use kde; then
		cp "${D}"/usr/share/applications/gparted.desktop \
			"${D}"/usr/share/applications/gparted-kde.desktop

		sed -i "s:Exec=:Exec=kdesu :" "${D}"/usr/share/applications/gparted-kde.desktop
		echo "OnlyShowIn=KDE;" >> "${D}"/usr/share/applications/gparted-kde.desktop
	fi

	if use gnome || use xfce; then
		sed -i "s:Exec=:Exec=gksu :" "${D}"/usr/share/applications/gparted.desktop
		echo "OnlyShowIn=GNOME;XFCE;" >> "${D}"/usr/share/applications/gparted.desktop
	else
		echo "OnlyShowIn=X-NeverShowThis;" >> "${D}"/usr/share/applications/gparted.desktop
	fi
}
