# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmitime/gkrellmitime-1.0.1.ebuild,v 1.12 2006/12/28 04:43:24 dirtyepic Exp $

inherit multilib eutils

IUSE=""
DESCRIPTION="Internet Time plugin for Gkrellm2"
HOMEPAGE="http://eric.bianchi.free.fr/gkrellm/"
SRC_URI="http://eric.bianchi.free.fr/Softwares/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc sparc alpha amd64"

DEPEND=">=app-admin/gkrellm-2"

src_compile() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins gkrellm_itime.so
	dodoc README ChangeLog COPYING
}
