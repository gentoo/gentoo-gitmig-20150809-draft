# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-bgchanger/gkrellm-bgchanger-0.0.4.ebuild,v 1.3 2003/09/06 05:45:17 msterret Exp $

IUSE="gtk gtk2"

MY_PN=gkrellmbgchg
MY_P=${MY_PN}-${PV}
MY_P2=${MY_PN}2-${PV}
S=${WORKDIR}/${MY_P}
S2=${WORKDIR}/${MY_P2}
DESCRIPTION="Plugin for GKrellM/GKrellM2 to change your desktop background"
HOMEPAGE="http://www.personal.uni-jena.de/~p6best/english/comp/gkrellmbgchg.html"
SRC_URI="http://www.personal.uni-jena.de/~p6best/comp/sources/${MY_P}.tar.gz
gtk2? http://www.personal.uni-jena.de/~p6best/comp/sources/${MY_P2}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="gtk2? ( =app-admin/gkrellm-2* )
	gtk? ( =app-admin/gkrellm-1.2* )"

src_unpack() {
	if [ -f /usr/bin/gkrellm ]
	then
		unpack ${MY_P}.tar.gz
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		unpack ${MY_P2}.tar.gz
	fi
}


src_compile() {
	if [ -f /usr/bin/gkrellm ]
	then
		cd ${S}
		emake || die
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		cd ${S2}
		emake || die
	fi
}

src_install() {
	if [ -f /usr/bin/gkrellm ]
	then
		cd ${S}
		insinto /usr/lib/gkrellm/plugins
		doins ${MY_PN}.so

		docinto gkrellm1
		dodoc README TODO
	fi

	if [ -f /usr/bin/gkrellm2 ]
	then
		cd ${S2}
		insinto /usr/lib/gkrellm2/plugins
		doins ${MY_PN}.so

		docinto gkrellm2
		dodoc ChangeLog README TODO
	fi
}
