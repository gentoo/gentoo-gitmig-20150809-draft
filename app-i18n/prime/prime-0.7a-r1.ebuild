# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-0.7a-r1.ebuild,v 1.3 2004/04/06 03:59:05 vapier Exp $

inherit ruby eutils

MY_P="${P/_pre*/-ss1}"
MY_P="${P/_rc/-rc}"
MY_P="${P/a/.a}"

DESCRIPTION="PRIME -- Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="emacs"

DEPEND="dev-lang/ruby
	app-dicts/prime-dict
	>=dev-ruby/sary-ruby-0.5_pre20030507-r1
	>=dev-libs/suikyo-1.3.0
	dev-ruby/ruby-progressbar"
PDEPEND="emacs? ( app-emacs/prime-el )"

S="${WORKDIR}/${MY_P}"

EXTRA_ECONF="--with-prime-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	epatch ${FILESDIR}/${MY_P}.1.diff
}

src_install() {
	einstall || die
	make DESTDIR=${D} install-etc || die

	erubydoc
}
