# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/mksh/mksh-9999.ebuild,v 1.2 2011/02/13 00:22:39 patrick Exp $

inherit eutils cvs

ECVS_SERVER="anoncvs.mirbsd.org:/cvs"
ECVS_MODULE="mksh"
ECVS_USER="_anoncvs"
ECVS_AUTH="ext"

DESCRIPTION="MirBSD Korn Shell"
HOMEPAGE="http://mirbsd.de/mksh"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""
DEPEND=""
RDEPEND=""
S="${WORKDIR}/${PN}"

src_unpack() {
	cvs_src_unpack
}

src_compile() {
	tc-export CC
	sh Build.sh -r || die
}

src_install() {
	exeinto /bin
	doexe mksh || die
	doman mksh.1 || die
	dodoc dot.mkshrc || die
}

src_test() {
	./test.sh || die
}
