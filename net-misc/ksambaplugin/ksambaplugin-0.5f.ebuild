# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ksambaplugin/ksambaplugin-0.5f.ebuild,v 1.7 2004/08/30 19:38:07 carlo Exp $

inherit kde eutils gcc

S=${WORKDIR}/${P/f/}/${P/f/}

DESCRIPTION="KDE 3 plugin for configuring a SAMBA server"
HOMEPAGE="http://ksambakdeplugin.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksambakdeplugin/${P/f/}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="debug"

DEPEND=">=kde-base/kdebase-3
	!>=kde-base/kdenetwork-3.3.0"
RDEPEND="${DEPEND}
	>=net-fs/samba-2.2.7"
need-kde 3

use debug && myconf="$myconf --enable-debug --enable-profile"
myconf="$myconf --enable-sso"

kde_src_unpack() {

	unpack ${A}
	cd ${WORKDIR}/ksambaplugin-0.5/ksambaplugin-0.5/src

	#apply patch to compile with gcc-3.4.0 closing bug #54391
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch ${FILESDIR}/ksambaplugin-gcc3.4-fix.patch
	fi
}
