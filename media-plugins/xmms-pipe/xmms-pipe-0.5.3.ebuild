# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-pipe/xmms-pipe-0.5.3.ebuild,v 1.7 2004/08/29 17:27:26 eradicator Exp $

MY_P=${P/-}
MY_PN=${PN/-}
S="${WORKDIR}/${MY_P}"

DESCRIPTION='XMMS plugin that allows you to control XMMS by sending strings to ${HOME}/.xmms/inpipe.'
SRC_URI="http://rooster.stanford.edu/~ben/xmmspipe/${MY_P}.tgz"
HOMEPAGE="http://rooster.stanford.edu/~ben/xmmspipe/"

DEPEND="media-sound/xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64 sparc"

IUSE=""

DOCS="COMMANDS HISTORY README fade.c"

src_compile() {
	emake COPT="${CFLAGS}" || die
}

src_install () {
	newbin fade xmmspipe-fade

	exeinto `xmms-config --general-plugin-dir`
	doexe xmmspipe.so

	dodoc ${DOCS}
}
