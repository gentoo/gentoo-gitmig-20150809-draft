# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/libxml/libxml-2.0.6.ebuild,v 1.1 2011/05/24 05:45:23 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_NAME="libxml-ruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc HISTORY"

inherit ruby-fakegem

DESCRIPTION="Ruby libxml with a user friendly API, akin to REXML, but feature complete and significantly faster."
HOMEPAGE="http://libxml.rubyforge.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND} dev-libs/libxml2"
DEPEND="${DEPEND} dev-libs/libxml2"

all_ruby_prepare() {
	# Remove grancher tasks only needed for publishing the website
	sed -i -e '/grancher/d' -e '/Grancher/,$d' Rakefile || die

	# We don't have the hanna template available.
	sed -i -e 's/hanna/rake/' Rakefile || die
}

each_ruby_configure() {
	${RUBY} -C ext/libxml extconf.rb || die
}

each_ruby_compile() {
	emake -C ext/libxml
	cp ext/libxml/libxml_ruby.so lib/ || die
}
