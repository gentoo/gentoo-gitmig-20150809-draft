# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/suikyo/suikyo-1.3.3_p20041117.ebuild,v 1.1 2004/11/18 15:17:32 usata Exp $

inherit ruby elisp-common

DESCRIPTION="Romaji Hiragana conversion library"
HOMEPAGE="http://taiyaki.org/suikyo/"
#SRC_URI="http://prime.sourceforge.jp/src/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P/_p/-}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~x86"
IUSE="emacs"

RDEPEND="emacs? ( virtual/emacs )"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake"

S="${WORKDIR}/${PN}"

RUBY_ECONF="--with-suikyo-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

src_compile() {
	./autogen.sh
	ruby_src_compile
}

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
