# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ksambaplugin/ksambaplugin-0.5_beta2.ebuild,v 1.1 2003/12/17 13:00:21 caleb Exp $

inherit kde
need-kde 3

MY_P=${P/_beta/b}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDE 3 plugin for configuring a SAMBA server"
HOMEPAGE="http://ksambakdeplugin.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksambakdeplugin/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="debug"

newdepend ">=kde-base/kdebase-3"
RDEPEND="${RDEPEND} >=net-fs/samba-2.2.7"

use debug && myconf="$myconf --enable-debug --enable-profile"
myconf="$myconf --enable-sso"
