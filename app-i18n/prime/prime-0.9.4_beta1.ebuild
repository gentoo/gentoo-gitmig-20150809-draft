# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-0.9.4_beta1.ebuild,v 1.1 2005/02/16 06:16:11 usata Exp $

inherit ruby

DESCRIPTION="Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P/_/-}.tar.gz"

LICENSE="GPL-2"
# 0.8.X -> stable, 0.9.Y -> development; dictionary format may change
# between releases in development branch, so please use it with care
SLOT="0"
KEYWORDS="~alpha ~ppc ~x86"
IUSE="emacs"

DEPEND=">=app-dicts/prime-dict-0.8.5
	>=dev-libs/suikyo-2.0.1_alpha2"
RDEPEND="${DEPEND}
	dev-ruby/ruby-progressbar
	dev-ruby/sary-ruby"
PDEPEND="emacs? ( app-emacs/prime-el )"

S="${WORKDIR}/${P/_/-}"

RUBY_ECONF="--with-prime-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

src_compile() {
	ruby_src_compile -j1
}

src_install() {
	make DESTDIR=${D} install install-etc || die

	erubydoc
}
