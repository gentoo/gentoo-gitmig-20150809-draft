# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tkman/tkman-2.1-r1.ebuild,v 1.13 2009/07/13 00:49:43 rbu Exp $

inherit eutils

DESCRIPTION="TkMan man and info page browser"
HOMEPAGE="http://tkman.sourceforge.net/"
SRC_URI="http://tkman.sourceforge.net/${PN}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=app-text/rman-3.0.9
	>=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${PF}-gentoo.diff

	# A workaround until app-text/rman-3.1 is stable
	has_version '>=sys-apps/groff-1.18' \
		has_version '<app-text/rman-3.1' \
		&& sed -i -e "s:groff -te -Tlatin1:groff -P -c -te -Tlatin1:" "${S}"/Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin ${PN} || die
	dobin re${PN}
}
