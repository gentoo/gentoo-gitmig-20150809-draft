# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/quintuple-agent/quintuple-agent-1.0.3.ebuild,v 1.15 2006/09/24 00:57:50 dragonheart Exp $

inherit eutils

DESCRIPTION="Quintuple Agent stores your (GnuPG) secrets in a secure manner."
HOMEPAGE="http://www.vibe.at/tools/q-agent"
SRC_URI="http://www.vibe.at/tools/q-agent/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="nls gtk"

COMMON_DEPEND="app-crypt/gnupg
	=dev-libs/glib-1.2*
	gtk? ( =x11-libs/gtk+-1.2* )"

RDEPEND="${COMMON_DEPEND}
	nls? ( virtual/libintl )"

DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-socklen_t.patch"
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO
	docinto doc
	dodoc doc/*.sgml
}
