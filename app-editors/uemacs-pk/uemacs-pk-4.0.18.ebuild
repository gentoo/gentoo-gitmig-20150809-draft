# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/uemacs-pk/uemacs-pk-4.0.18.ebuild,v 1.6 2010/09/02 14:44:07 fauli Exp $

EAPI=3

inherit eutils toolchain-funcs

DESCRIPTION="uEmacs/PK is an enhanced version of MicroEMACS"
HOMEPAGE="ftp://ftp.cs.helsinki.fi/pub/Software/Local/uEmacs-PK"
SRC_URI="ftp://ftp.cs.helsinki.fi/pub/Software/Local/uEmacs-PK/em-${PV}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

S="${WORKDIR}/em-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	# Respect LDFLAGS when linking, bug 335516
	sed -e 's:${CC} ${DEFINES} -o emacs ${OBJ} ${LIBS}:${CC} ${DEFINES} ${LDFLAGS} -o emacs ${OBJ} ${LIBS}:' -i "${S}"/makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	newbin emacs uemacs
	insinto /usr/share/${PN}
	doins emacs.hlp
	newins emacs.rc .emacsrc
	dodoc readme readme.39e emacs.ps || die
}
