# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-0.6.3.ebuild,v 1.1 2003/12/24 23:02:27 usata Exp $

inherit ruby

IUSE="emacs"

DESCRIPTION="PRIME -- Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

S="${WORKDIR}/${P}"

DEPEND="dev-lang/ruby
	app-dicts/prime-dict
	>=dev-ruby/sary-ruby-0.5_pre20030507-r1
	>=dev-libs/suikyo-1.2.0
	emacs? ( app-emacs/prime-el )"

EXTRA_ECONF="--with-prime-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

src_install() {

	einstall || die
	# sary-ruby has been patched and now prime can work with both
	# ruby 1.6 and 1.8 (25 Dec 2003)
	#if [ -x "/usr/bin/ruby16" ] ; then
	#	dosed "s:/usr/bin/env ruby:/usr/bin/ruby16:g" /usr/bin/prime
	#fi
	make DESTDIR=${D} install-etc || die

	erubydoc

}
