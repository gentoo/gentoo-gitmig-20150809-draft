# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-seti/gkrellm-seti-0.7.0b-r1.ebuild,v 1.7 2004/08/15 06:30:33 dragonheart Exp $

inherit eutils

IUSE=""
S=${WORKDIR}/${P//gkrellm-}
DESCRIPTION="a Seti@Home Monitor Plugin for Gkrellm"
SRC_URI="http://xavier.serpaggi.free.fr/seti/${P//gkrellm-}.tar.bz2 http://xavier.serpaggi.free.fr/seti/GKrellM_seti_plugin_GTK+2.tgz"
HOMEPAGE="http://xavier.serpaggi.free.fr/seti"

DEPEND="=app-admin/gkrellm-2.1*"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~alpha"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/gentoo-gkrellm-seti-path.patch || die "failed to apply patch"
	mv ${WORKDIR}/Makefile ${S}
	mv ${WORKDIR}/seti.c ${S}
	mv ${WORKDIR}/seti.h ${S}
}

src_compile() {
	make || die
}

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	doexe seti.so
	dodoc README ChangeLog COPYING NEWS
}
