# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ksambaplugin/ksambaplugin-0.4.2.ebuild,v 1.1 2003/02/26 22:28:06 verwilst Exp $

inherit kde-base
need-kde 3

IUSE=""
DESCRIPTION="KSambaPlugin is a KDE 3 plugin for configuring a SAMBA server."
SRC_URI="mirror://sourceforge/ksambakdeplugin/${P}.tar.bz2"
HOMEPAGE="http://ksambakdeplugin.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

newdepend ">=kde-base/kdebase-3"
	
RDEPEND="$RDEPEND >=net-fs/samba-2.2.7"

myconf="$myconf --enable-sso"
[ -n "$DEBUG" ] && myconf="$myconf --enable-debugging --enable-profiling" || myconf="$myconf --disable-debugging --disable-profiling"


