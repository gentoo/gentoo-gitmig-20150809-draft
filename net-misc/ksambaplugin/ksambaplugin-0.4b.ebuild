# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit kde-base
need-kde 3

IUSE=""
DESCRIPTION="KSambaPlugin is a KDE 3 plugin for configuring a SAMBA server."
SRC_URI="mirror://sourceforge/ksambakdeplugin/${P}.tar.bz2"
HOMEPAGE="http://ksambakdeplugin.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86"

newdepend ">=kde-base/kdebase-3"
	
RDEPEND="$RDEPEND >=net-fs/samba-2.2.7"

myconf="$myconf --enable-sso"
[ -n "$DEBUG" ] && myconf="$myconf --enable-debugging --enable-profiling" || myconf="$myconf --disable-debugging --disable-profiling"


