# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/apwal/apwal-0.4.5.ebuild,v 1.3 2005/08/13 23:26:38 hansmi Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="A simple application launcher and combined editor"
HOMEPAGE="http://apwal.free.fr/"
SRC_URI="http://apwal.free.fr/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}

	# ugly hardcoded cflags
	sed -i \
		-e "s:-O2:${CFLAGS}:" src/Makefile \
			|| die "sed src/Makefile failed"
	# make parallel make happy
	sed -i \
		-e "/cd src/ c\	\$(MAKE) -C src \$@" Makefile \
			|| die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin src/apwal                   || die "dobin failed"
	dosym apwal /usr/bin/apwal-editor || die "dosym failed"
	dodoc ABOUT Changelog FAQ README  || die "dodoc failed"
}
