# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qtparted/qtparted-0.4.1.ebuild,v 1.1 2004/01/22 02:47:46 caleb Exp $

inherit kde
need-qt 3.1

DESCRIPTION="QtParted is a nice Qt partition tool for Linux"
HOMEPAGE="http://qtparted.sourceforge.net"
SRC_URI="mirror://sourceforge/qtparted/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/qt-3.1.0
	>=sys-apps/parted-1.6.6
	>=sys-fs/e2fsprogs-1.33
	>=sys-fs/progsreiserfs-0.3.0.4
	>=sys-fs/xfsprogs-2.3.9
	>=sys-fs/jfsutils-1.1.2
	>=sys-fs/ntfsprogs-1.7.1"
