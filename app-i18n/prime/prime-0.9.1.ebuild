# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-0.9.1.ebuild,v 1.5 2004/09/07 07:56:14 usata Exp $

inherit ruby

IUSE="emacs"

DESCRIPTION="PRIME -- Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P/_/-}.tar.gz"

LICENSE="GPL-2"
# 0.8.X -> stable, 0.9.Y -> development; dictionary format may change
# between releases in development branch, so please use it with care
KEYWORDS="~x86 ~alpha ~ppc"
SLOT="0"

DEPEND="virtual/ruby
	app-dicts/prime-dict
	>=dev-libs/suikyo-1.3.0
	dev-ruby/ruby-progressbar"
PDEPEND="emacs? ( app-emacs/prime-el )"

EXTRA_ECONF="--with-prime-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

S="${WORKDIR}/${P/_/-}"

src_install() {

	einstall || die
	make DESTDIR=${D} install-etc || die

	erubydoc

}
