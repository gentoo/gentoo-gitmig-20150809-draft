# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-termios/ruby-termios-0.9.6.ebuild,v 1.2 2010/01/10 20:57:25 maekke Exp $

EAPI=2

RUBY_BUG_145222=yes
inherit ruby eutils

DESCRIPTION="A Ruby interface to termios"
HOMEPAGE="http://arika.org/ruby/termios"	# trailing / isn't needed
SRC_URI="http://github.com/arika/ruby-termios/tarball/version_0_9_6 -> ${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~sparc x86"
IUSE="examples"
USE_RUBY="ruby18"

S="${WORKDIR}/arika-${PN}-94fd9ac"

src_test() {
	${RUBY} test/test0.rb
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README termios.rd
	use examples && docinto examples && dodoc examples/*
}
