# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/global/global-5.9.2-r2.ebuild,v 1.1 2010/09/10 16:15:23 jer Exp $

EAPI="3"

inherit autotools elisp-common

DESCRIPTION="GNU Global is a tag system to find the locations of a specified object in various sources."
HOMEPAGE="http://www.gnu.org/software/global/global.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc vim emacs"

RDEPEND="vim? ( || ( app-editors/vim app-editors/gvim ) )
	emacs? ( virtual/emacs )"
DEPEND="${DEPEND}
	doc? ( app-text/texi2html sys-apps/texinfo )"

SITEFILE="50gtags-gentoo.el"

src_prepare() {
	epatch "${FILESDIR}"/${P}-localstatedir.patch
	eautoreconf
}

src_configure() {
	econf "$(use_with emacs lispdir "${SITELISP}/${PN}")"
}

src_compile() {
	if use doc; then
		texi2pdf -q -o doc/global.pdf doc/global.texi
		texi2html -o doc/global.html doc/global.texi
	fi

	if use emacs; then
		elisp-compile *.el || die "elisp-compile failed"
	fi

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		dohtml doc/global.html
		[[ -f doc/global.pdf ]] && dodoc doc/global.pdf
	fi

	dodoc AUTHORS FAQ NEWS README THANKS

	insinto /etc
	doins gtags.conf

	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins gtags.vim
	fi

	if use emacs; then
		elisp-install ${PN} *.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
