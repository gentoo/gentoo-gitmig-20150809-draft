# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-env/gnustep-env-0.1.4.ebuild,v 1.4 2004/10/31 12:05:51 kloeri Exp $

inherit gnustep

DESCRIPTION="This is a convience package that installs all base GNUstep libraries, convenience scripts, and environment settings for use on Gentoo."
# These are support files for GNUstep on Gentoo, so setting
#   homepage thusly
HOMEPAGE="http://www.gnustep.org"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

src_unpack() {
	echo "nothing to unpack"
}

src_compile() {
	echo "nothing to compile"
}

src_install() {
	exeinto /etc/init.d
	newexe ${FILESDIR}/gnustep.runscript-${PV} gnustep
	dosed "s:XXX_GENTOO_GNUSTEP_ROOT_XXX:${GENTOO_GNUSTEP_ROOT}:g" /etc/init.d/gnustep
	insinto /etc/env.d
	newins ${FILESDIR}/gnustep.env-${PV} 99gnustep
	dosed "s:XXX_GENTOO_GNUSTEP_ROOT_XXX:${GENTOO_GNUSTEP_ROOT}:g" /etc/env.d/99gnustep
	dodir /var/run/GNUstep
	einfo "Check http://dev.gentoo.org/~fafhrd/ for very handy info in setting up your GNUstep env."
}

