# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/suikyo/suikyo-1.3.3.ebuild,v 1.1 2004/08/29 19:42:38 usata Exp $

inherit ruby elisp-common

IUSE="emacs"

DESCRIPTION="Romaji Hiragana conversion library"
HOMEPAGE="http://taiyaki.org/suikyo/"
SRC_URI="http://prime.sourceforge.jp/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc"
SLOT="0"

DEPEND="virtual/ruby
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
