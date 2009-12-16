# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gwydion-dylan/gwydion-dylan-2.4.0-r1.ebuild,v 1.2 2009/12/16 10:14:21 flameeyes Exp $

inherit eutils elisp-common

DESCRIPTION="The Dylan Programming Language Compiler"
HOMEPAGE="http://www.gwydiondylan.org/"
SRC_URI="http://www.gwydiondylan.org/downloads/src/tar/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk emacs"

DEPEND="( || ( dev-lang/gwydion-dylan-bin
	dev-lang/gwydion-dylan ) )
	>=dev-libs/boehm-gc-6.4
	emacs? ( virtual/emacs )
	gtk? ( =x11-libs/gtk+-1.2* )"
RDEPEND=""

SITEFILE=50gwydion-dylan-gentoo.el

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/gd-gc.patch"
}

src_compile() {
	./configure \
		--prefix=/usr \
		--build="${CHOST}" \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$(use_with gtk) \
		|| die "./configure failed"
	emake -j1 || die "emake failed"
	if use emacs; then
		elisp-compile "${S}"/tools/elisp/*.el
	fi
}

src_install() {
	emake -j1 DESTDIR="${D}" install \
		|| die "make failed"
	if use emacs; then
		elisp-install "${PN}" "${S}"/tools/elisp/*.el "${S}"/tools/elisp/*.elc
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	doenvd "${FILESDIR}/20gwydion-dylan"
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
