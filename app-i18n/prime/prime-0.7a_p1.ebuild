# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-0.7a_p1.ebuild,v 1.1 2004/03/02 19:19:54 usata Exp $

inherit ruby

IUSE="emacs"

MY_P="${P}"
MY_P="${P/_pre*/-ss1}"
MY_P="${MY_P/_rc/-rc}"
MY_P="${MY_P/a/.a}"
MY_P="${MY_P/_p/.}"

DESCRIPTION="PRIME -- Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

S="${WORKDIR}/${MY_P}"

DEPEND="dev-lang/ruby
	app-dicts/prime-dict
	>=dev-ruby/sary-ruby-0.5_pre20030507-r1
	>=dev-libs/suikyo-1.3.0
	dev-ruby/ruby-progressbar"
PDEPEND="emacs? ( app-emacs/prime-el )"

EXTRA_ECONF="--with-prime-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

src_install() {

	einstall || die
	make DESTDIR=${D} install-etc || die

	erubydoc

}
