# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/gparted/gparted-0.3.7.ebuild,v 1.1 2008/05/04 11:43:14 eva Exp $

inherit eutils gnome2

DESCRIPTION="Gnome Partition Editor"
HOMEPAGE="http://gparted.sourceforge.net/"

SRC_URI="mirror://sourceforge/gparted/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="fat hfs jfs ntfs reiserfs reiser4 xfs"

common_depends=">=sys-apps/parted-1.7.1
		>=dev-cpp/gtkmm-2.8.0"

RDEPEND="${common_depends}
		x11-libs/gksu
		fat? ( sys-fs/dosfstools )
		ntfs? ( sys-fs/ntfsprogs )
		hfs? ( sys-fs/hfsutils )
		jfs? ( sys-fs/jfsutils )
		reiserfs? ( sys-fs/reiserfsprogs )
		reiser4? ( sys-fs/reiser4progs )
		xfs? ( sys-fs/xfsprogs sys-fs/xfsdump )"

DEPEND="${common_depends}
		>=dev-util/pkgconfig-0.12
		>=dev-util/intltool-0.35.5"

src_unpack() {
	gnome2_src_unpack

	sed -i "s:Exec=:Exec=gksu :" gparted.desktop.in.in
}
