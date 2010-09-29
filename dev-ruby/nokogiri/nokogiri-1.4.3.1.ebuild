# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nokogiri/nokogiri-1.4.3.1.ebuild,v 1.4 2010/09/29 00:00:23 ranger Exp $

EAPI=2

# jruby → needs weakling for testing , will add back in a bit
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc CHANGELOG.ja.rdoc README.rdoc README.ja.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="Nokogiri is an HTML, XML, SAX, and Reader parser."
HOMEPAGE="http://nokogiri.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
SLOT="0"
IUSE="ffi"

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
	test? ( dev-ruby/minitest )"

ruby_add_rdepend "ffi? ( virtual/ruby-ffi )"

# USE_RUBY=jruby \
# 	ruby_add_bdepend "test? ( dev-ruby/weakling )"

all_ruby_prepare() {
	sed -i \
		-e '/tasks\/cross_compile/s:^:#:' \
		-e '/:test.*prerequisites/s:^:#:' \
		Rakefile || die
}

nokogiri_ffi() {
	[[ $(basename ${RUBY}) == "jruby" ]] || use ffi
}

each_ruby_configure() {
	nokogiri_ffi && return
	${RUBY} -Cext/${PN} extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	if ! [[ -f lib/nokogiri/css/generated_tokenizer.rb ]]; then
		${RUBY} -S rake lib/nokogiri/css/generated_tokenizer.rb || die "rexical failed"
	fi

	nokogiri_ffi && return
	emake -Cext/${PN} \
		CFLAGS="${CFLAGS} -fPIC" \
		archflag="${LDFLAGS}" || die "make extension failed"
	cp -l ext/${PN}/${PN}.so lib/${PN}/ || die
}

each_ruby_test() {
	nokogiri_ffi && export NOKOGIRI_FFI=yes
	each_fakegem_test
}
