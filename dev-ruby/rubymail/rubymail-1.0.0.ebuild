# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubymail/rubymail-1.0.0.ebuild,v 1.8 2009/04/26 14:46:36 ranger Exp $

inherit ruby

DESCRIPTION="A mail handling library for Ruby"
HOMEPAGE="http://www.lickey.com/rubymail/"
SRC_URI="http://rubyforge.org/frs/download.php/30221/rmail-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86"
USE_RUBY="ruby18"
IUSE=""
DEPEND="virtual/ruby"
S="${WORKDIR}/rmail-${PV}"

src_compile() {
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix="${D}/usr" || die
	ruby install.rb install || die
	dodoc NEWS NOTES README THANKS TODO
	dohtml -r doc/*
	cp -r guide "${D}/usr/share/doc/${PF}"
}

src_test() {
	ruby test/runtests.rb || die "runtests.rb failed."
}
