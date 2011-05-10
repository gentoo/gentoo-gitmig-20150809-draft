# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtypist/gtypist-2.8.5.ebuild,v 1.1 2011/05/10 08:39:59 xmw Exp $

EAPI=2

inherit eutils elisp-common

DESCRIPTION="Universal typing tutor"
HOMEPAGE="http://www.gnu.org/software/gtypist/"
SRC_URI="mirror://gnu/gtypist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls emacs xemacs"

DEPEND=">=sys-libs/ncurses-5.2
	emacs? ( virtual/emacs )
	xemacs? ( !emacs? ( app-editors/xemacs app-xemacs/fsf-compat ) )"

RDEPEND="${DEPEND}"

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.8.3-xemacs-compat.patch
}

src_configure() {
	local lispdir=""
	if use emacs; then
		lispdir="${SITELISP}/${PN}"
		einfo "Configuring to build with GNU Emacs support"
	elif use xemacs; then
		lispdir="/usr/lib/xemacs/site-packages/lisp/${PN}"
		einfo "Configuring to build with XEmacs support"
	fi

	econf $(use_enable nls) \
		EMACS=$(usev emacs || usev xemacs || echo no) \
		--with-lispdir="${lispdir}"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
