# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-devel/ion-devel-20031121.ebuild,v 1.1 2003/12/07 16:07:28 twp Exp $

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5.0.1_beta20031003"
S=${WORKDIR}/${P/_p/-}

inherit ion-devel

src_install() {

	ion-devel_src_install

	dobin scripts/pwm

	echo -e "#!/bin/sh\n/usr/bin/ion" > ${T}/ion-devel
	echo -e "#!/bin/sh\n/usr/bin/pwm" > ${T}/pwm
	exeinto /etc/X11/Sessions
	doexe ${T}/ion-devel ${T}/pwm

}
