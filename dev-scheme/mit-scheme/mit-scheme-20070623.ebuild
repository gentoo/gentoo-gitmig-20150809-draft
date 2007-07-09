# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/mit-scheme/mit-scheme-20070623.ebuild,v 1.1 2007/07/09 13:53:53 hkbst Exp $

MY_SUF="ix86-gnu-linux"
DESCRIPTION="GNU/MIT-Scheme Binary package"
HOMEPAGE="http://www.swiss.ai.mit.edu/projects/scheme/"
SRC_URI="http://ftp.gnu.org/gnu/mit-scheme/snapshot.pkg/${PV}/${P}-${MY_SUF}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="doc"
S="${WORKDIR}"

RDEPEND="x11-libs/libXau
		 x11-libs/libSM
		 x11-libs/libXdmcp
		 x11-libs/libX11
		 x11-libs/libICE"

src_install() {
	exeinto /opt/mit-scheme/bin/
	doexe bin/*

	use doc && dohtml lib/mit-scheme/doc/{index.html,mit-scheme-imail/*,mit-scheme-ref/*,mit-scheme-sos/*,mit-scheme-user/*}
	doinfo lib/mit-scheme/edwin/info/mit-scheme-*
	rm -rf lib/mit-scheme/{doc,edwin/info}

	insinto /opt/mit-scheme/lib/
	doins -r lib/*

	echo -e "#!/bin/bash\n/opt/mit-scheme/bin/scheme -library /opt/mit-scheme/lib/mit-scheme \$*" >> mit-scheme
	echo -e "#!/bin/bash\n/opt/mit-scheme/bin/bchscheme -library /opt/mit-scheme/lib/mit-scheme \$*" >> mit-bchscheme
	dobin mit-scheme mit-bchscheme
}
