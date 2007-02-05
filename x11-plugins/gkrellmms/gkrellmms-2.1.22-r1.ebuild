# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmms/gkrellmms-2.1.22-r1.ebuild,v 1.4 2007/02/05 15:46:39 armin76 Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="A sweet plugin to control Audacious from GKrellM2"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellmms.phtml"
IUSE=""
DEPEND=">=app-admin/gkrellm-2
	media-sound/audacious"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-audacious.patch
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	tc-export CC
	emake USE_AUDACIOUS=1 || die
}

src_install () {
	exeinto /usr/"$(get_libdir)"/gkrellm2/plugins
	doexe gkrellmms.so
	dodoc README Changelog FAQ Themes
}
