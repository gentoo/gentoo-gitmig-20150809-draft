# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/suikyo/suikyo-1.3.2.ebuild,v 1.3 2004/03/27 15:43:38 usata Exp $

inherit ruby elisp-common

IUSE="emacs"

DESCRIPTION="Romaji Hiragana conversion library"
HOMEPAGE="http://taiyaki.org/suikyo/"
SRC_URI="http://prime.sourceforge.jp/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"
S="${WORKDIR}/${P}"

DEPEND="dev-lang/ruby
	emacs? ( virtual/emacs )"

EXTRA_ECONF="--with-suikyo-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

src_install() {

	einstall || die
	erubydoc

	use emacs || rm -rf ${D}/usr/share/emacs/
	use emacs && elisp-site-file-install ${FILESDIR}/50suikyo-gentoo.el

}

pkg_postinst() {

	use emacs && elisp-site-regen

}

pkg_postrm() {

	use emacs && elisp-site-regen

}
