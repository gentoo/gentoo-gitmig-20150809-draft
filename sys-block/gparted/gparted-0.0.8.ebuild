# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/gparted/gparted-0.0.8.ebuild,v 1.2 2005/06/23 19:32:33 swegener Exp $

inherit gnome2

DESCRIPTION="Gnome Partition Editor"
HOMEPAGE="http://gparted.sourceforge.net/"

SRC_URI="mirror://sourceforge/gparted/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="fat hfs jfs ntfs xfs reiserfs"

RDEPEND=">=sys-apps/parted-1.6.13
		>=dev-cpp/gtkmm-2.4.0
		fat? ( sys-fs/dosfstools )
		ntfs? ( sys-fs/ntfsprogs )
		hfs? ( sys-fs/hfsutils )
		jfs? ( sys-fs/jfsutils )
		reiserfs? ( sys-fs/reiserfsprogs )"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.12
		>=dev-util/intltool-0.29"
