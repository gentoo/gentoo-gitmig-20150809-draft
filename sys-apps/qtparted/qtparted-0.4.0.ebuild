# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qtparted/qtparted-0.4.0.ebuild,v 1.3 2003/11/18 19:32:46 caleb Exp $

inherit kde
need-qt 3.1

DESCRIPTION="QtParted is a nice Qt partition tool for Linux"
HOMEPAGE="http://qtparted.sourceforge.net"
SRC_URI="mirror://sourceforge/qtparted/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/qt-3.1.0
	>=sys-apps/parted-1.6.6
	>=sys-fs/e2fsprogs-1.33
	>=sys-fs/progsreiserfs-0.3.0.4
	>=sys-fs/xfsprogs-2.3.9
	>=sys-fs/jfsutils-1.1.2
	>=sys-fs/ntfsprogs-1.7.1"
