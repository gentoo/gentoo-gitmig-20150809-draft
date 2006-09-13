# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubymail/rubymail-0.17.ebuild,v 1.9 2006/09/13 12:06:57 fmccor Exp $

inherit ruby

DESCRIPTION="A mail handling library for Ruby"
HOMEPAGE="http://www.lickey.com/rubymail/"
SRC_URI="http://www.lickey.com/rubymail/download/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ~ppc ppc64 sparc ~x86"
USE_RUBY="any"
IUSE=""
DEPEND="virtual/ruby"

src_compile() {
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die
	dodoc NEWS NOTES README THANKS TODO
	dohtml -r doc/*
	cp -r guide ${D}/usr/share/doc/${PF}
}

src_test() {
	ruby tests/runtests.rb || die "runtests.rb failed."
}
