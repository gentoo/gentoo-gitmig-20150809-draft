# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-1.0.0.1.ebuild,v 1.1 2005/03/30 04:47:29 usata Exp $

inherit ruby

DESCRIPTION="Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~x86"
IUSE="emacs"

DEPEND=">=app-dicts/prime-dict-1.0.0
	>=dev-libs/suikyo-2.1.0"
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
