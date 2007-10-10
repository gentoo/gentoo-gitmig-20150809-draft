# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/uemacs-pk/uemacs-pk-4.0.18.ebuild,v 1.2 2007/10/10 07:21:43 ulm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="uEmacs/PK is an enhanced version of MicroEMACS"
HOMEPAGE="ftp://ftp.cs.helsinki.fi/pub/Software/Local/uEmacs-PK"
SRC_URI="ftp://ftp.cs.helsinki.fi/pub/Software/Local/uEmacs-PK/em-${PV}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

S="${WORKDIR}/em-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	newbin emacs uemacs
	insinto /usr/share/${PN}
	doins emacs.hlp
	newins emacs.rc .emacsrc
	dodoc readme readme.39e emacs.ps || die "dodoc failed"
}
