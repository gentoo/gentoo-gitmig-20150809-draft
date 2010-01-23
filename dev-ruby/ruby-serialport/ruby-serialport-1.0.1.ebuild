# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-serialport/ruby-serialport-1.0.1.ebuild,v 1.1 2010/01/23 07:36:45 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

MY_P=${P/ruby-/}
DESCRIPTION="a library for serial port (rs232) access in ruby"
HOMEPAGE="http://rubyforge.org/projects/ruby-serialport/"
SRC_URI="mirror://rubygems/${MY_P}.gem"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~ppc ~x86"
IUSE=""

each_ruby_configure() {
	cd ext/native
	${RUBY} extconf.rb || die
}

each_ruby_compile() {
	cd ext/native
	emake || die
}

each_ruby_install() {
	ruby_fakegem_genspec

	cd ext/native
	emake DESTDIR="${D}" install || die
}
