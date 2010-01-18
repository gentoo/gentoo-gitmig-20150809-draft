# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mechanize/mechanize-0.9.3-r1.ebuild,v 1.1 2010/01/18 17:02:07 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="redocs"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc EXAMPLES.rdoc FAQ.rdoc GUIDE.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A Ruby library used for automating interaction with websites."
HOMEPAGE="http://mechanize.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

ruby_add_rdepend ">=dev-ruby/nokogiri-1.2.1"

all_ruby_prepare() {
	# three tests will fail because the needed datafiles are missing
	# in the gems, and we cannot use a github tarball because this
	# version is not tagged:
	# http://github.com/tenderlove/mechanize/issues#issue/24
	# http://github.com/tenderlove/mechanize/issues#issue/23
	sed -i \
		-e '/^  def test_encoding_override_after_parser_was_initialized/, /^  end/ s:^:#:' \
		-e '/^  def test_encoding_override_before_parser_initialized/, /^  end/ s:^:#:' \
		-e '/^  def test_page_gets_charset_from_page/, /^  end/ s:^:#:' \
		test/test_page.rb || die
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die
}
