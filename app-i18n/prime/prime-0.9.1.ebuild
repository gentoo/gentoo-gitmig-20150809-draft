# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-0.9.1.ebuild,v 1.6 2004/09/23 23:53:57 vapier Exp $

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

DEPEND="virtual/ruby
	app-dicts/prime-dict
	>=dev-libs/suikyo-1.3.0
	dev-ruby/ruby-progressbar"
PDEPEND="emacs? ( app-emacs/prime-el )"

S="${WORKDIR}/${P/_/-}"

RUBY_ECONF="--with-prime-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

src_install() {
	einstall || die
	make DESTDIR=${D} install-etc || die

	erubydoc
}
