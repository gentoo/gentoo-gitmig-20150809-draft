# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-bfm/gkrellm-bfm-0.6.4.ebuild,v 1.4 2007/03/24 14:39:34 armin76 Exp $

inherit gkrellm-plugin

IUSE=""
S=${WORKDIR}/bfm-${PV}
DESCRIPTION="A Gkrellm2 system monitor plugin, with bubbles, fish, and a rubber duck."
SRC_URI="http://www.jnrowe.ukfsn.org/data/bfm-${PV}.tar.bz2"
HOMEPAGE="http://www.jnrowe.ukfsn.org/projects/bfm.html"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~ppc sparc x86"

PLUGIN_DOCS="SUPPORTED_SYSTEMS"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${P}-cflags.patch || die "Patch failed"
}

src_compile() {
	emake STRIP=echo gkrellm
}

