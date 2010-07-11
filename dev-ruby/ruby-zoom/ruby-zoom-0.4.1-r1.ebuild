# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-zoom/ruby-zoom-0.4.1-r1.ebuild,v 1.1 2010/07/11 19:20:02 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_NAME="${PN/ruby-/}"

RUBY_FAKEGEM_DOCDIR="html"
RUBY_FAKEGEM_EXTRADOC="ChangeLog README"

inherit multilib ruby-fakegem

IUSE=""

DESCRIPTION="A Ruby binding to the Z39.50 Object-Orientation Model (ZOOM)"
HOMEPAGE="http://ruby-zoom.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

DEPEND="${DEPEND} dev-libs/yaz"
RDEPEND="${RDEPEND} dev-libs/yaz"

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

each_ruby_configure() {
	${RUBY} -Csrc extconf.rb || die
}

each_ruby_compile() {
	emake -Csrc || die
}

each_ruby_install() {
	mkdir lib || die
	cp src/zoom$(get_modname) lib/ || die

	each_fakegem_install
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r sample
}
