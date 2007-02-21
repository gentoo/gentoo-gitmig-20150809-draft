# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-bfm/gkrellm-bfm-0.6.4.ebuild,v 1.1 2007/02/21 19:53:36 lack Exp $

inherit multilib eutils

IUSE=""
S=${WORKDIR}/bfm-${PV}
DESCRIPTION="A Gkrellm2 system monitor plugin, with bubbles, fish, and a rubber duck."
SRC_URI="http://www.jnrowe.ukfsn.org/data/bfm-${PV}.tar.bz2"
HOMEPAGE="http://www.jnrowe.ukfsn.org/projects/bfm.html"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="=app-admin/gkrellm-2*"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${P}-cflags.patch || die "Patch failed"
}

src_compile() {
	emake gkrellm || die
}

src_install () {
	exeinto /usr/$(get_libdir)/gkrellm2/plugins
	doexe gkrellm-bfm.so
	dodoc README README.bubblemon COPYING TODO SUPPORTED_SYSTEMS
}
