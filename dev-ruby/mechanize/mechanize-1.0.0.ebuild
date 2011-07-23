# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mechanize/mechanize-1.0.0.ebuild,v 1.3 2011/07/23 14:28:27 xarthisius Exp $

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
KEYWORDS="~amd64 ppc ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

ruby_add_bdepend ">=dev-ruby/hoe-2.3.3"
ruby_add_rdepend ">=dev-ruby/nokogiri-1.2.1"

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die
}
