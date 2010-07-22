# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmitime/gkrellmitime-1.0.1.ebuild,v 1.15 2010/07/22 14:30:07 ssuominen Exp $

inherit gkrellm-plugin

IUSE=""
DESCRIPTION="Internet Time plugin for Gkrellm2"
HOMEPAGE="http://eric.bianchi.free.fr/gkrellm/"
SRC_URI="http://eric.bianchi.free.fr/Softwares/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc sparc alpha amd64"

PLUGIN_SO=gkrellm_itime.so

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
}
