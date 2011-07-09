# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nokogiri/nokogiri-1.5.0.ebuild,v 1.1 2011/07/09 10:15:44 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc CHANGELOG.ja.rdoc README.rdoc README.ja.rdoc"

inherit ruby-fakegem eutils multilib

DESCRIPTION="Nokogiri is an HTML, XML, SAX, and Reader parser."
HOMEPAGE="http://nokogiri.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
SLOT="0"
IUSE=""

RDEPEND="${RDEPEND}
	dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${DEPEND}
	dev-libs/libxml2
	dev-libs/libxslt"

# The tests require _minitest_, not the virtual; what is shipped with
# Ruby 1.9 is *not* enough, unfortunately
ruby_add_bdepend "
	dev-ruby/rake-compiler
	dev-ruby/rexical
	dev-ruby/hoe
	dev-ruby/racc
	doc? ( dev-ruby/rdoc )
	test? ( dev-ruby/minitest )"

all_ruby_prepare() {
	sed -i \
		-e '/tasks\/cross_compile/s:^:#:' \
		-e '/:test.*prerequisites/s:^:#:' \
		Rakefile || die
	# Remove the cross compilation options since they interfere with
	# native building.
	sed -i -e 's/cross_compile  = true/cross_compile = false/' Rakefile || die
	sed -i -e '/cross_config_options/d' Rakefile || die
}

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	if ! [[ -f lib/nokogiri/css/tokenizer.rb ]]; then
		${RUBY} -S rake lib/nokogiri/css/tokenizer.rb || die "rexical failed"
	fi

	emake -Cext/${PN} \
		CFLAGS="${CFLAGS} -fPIC" \
		archflag="${LDFLAGS}" || die "make extension failed"
	cp -l ext/${PN}/${PN}$(get_modname) lib/${PN}/ || die
}

each_ruby_test() {
	each_fakegem_test
}
