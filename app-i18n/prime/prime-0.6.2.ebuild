# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-0.6.2.ebuild,v 1.2 2003/12/10 22:53:34 usata Exp $

inherit ruby

IUSE="emacs"

DESCRIPTION="PRIME -- Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

S="${WORKDIR}/${P}"

DEPEND="=dev-lang/ruby-1.6*
	app-dicts/prime-dict
	dev-ruby/sary-ruby
	dev-libs/suikyo
	emacs? ( app-emacs/prime-el )"

EXTRA_ECONF="--with-prime-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

src_install() {

	einstall || die
	if [ -x "/usr/bin/ruby16" ] ; then
		dosed "s:/usr/bin/env ruby:/usr/bin/ruby16:g" /usr/bin/prime
	fi
	make DESTDIR=${D} install-etc || die

	erubydoc

}
