# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ksambaplugin/ksambaplugin-0.5f.ebuild,v 1.5 2004/07/03 21:21:25 carlo Exp $

inherit kde

S=${WORKDIR}/${P/f/}/${P/f/}

DESCRIPTION="KDE 3 plugin for configuring a SAMBA server"
HOMEPAGE="http://ksambakdeplugin.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksambakdeplugin/${P/f/}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="debug"

DEPEND=">=kde-base/kdebase-3"
RDEPEND="${DEPEND}
	>=net-fs/samba-2.2.7"
need-kde 3

use debug && myconf="$myconf --enable-debug --enable-profile"
myconf="$myconf --enable-sso"
