# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ksambaplugin/ksambaplugin-0.4.2.ebuild,v 1.3 2003/08/19 22:19:45 vapier Exp $

inherit kde-base
need-kde 3

DESCRIPTION="KDE 3 plugin for configuring a SAMBA server"
HOMEPAGE="http://ksambakdeplugin.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksambakdeplugin/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="debug"

newdepend ">=kde-base/kdebase-3"
RDEPEND="${RDEPEND} >=net-fs/samba-2.2.7"

use debug && myconf="$myconf --enable-debugging --enable-porfiling"
myconf="$myconf --enable-sso"
