# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-0.7.8.ebuild,v 1.3 2004/03/21 21:38:15 usata Exp $

inherit ruby

IUSE="emacs"

MY_P="${P/_pre*/-ss1}"
MY_P="${P/_rc/-rc}"

DESCRIPTION="PRIME -- Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
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
