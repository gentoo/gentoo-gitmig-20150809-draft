# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdoc/rdoc-3.12.ebuild,v 1.2 2012/02/05 21:01:47 maekke Exp $

EAPI=3
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc RI.rdoc TODO.rdoc"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem eutils

DESCRIPTION="An extended version of the RDoc library from Ruby 1.8"
HOMEPAGE="https://github.com/rdoc/rdoc/"

LICENSE="Ruby MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	dev-ruby/racc
	doc? ( >=dev-ruby/hoe-2.7.0 )
	test? (
		>=dev-ruby/hoe-2.7.0
		dev-ruby/minitest
	)"

ruby_add_rdepend "=dev-ruby/json-1* >=dev-ruby/json-1.4"

# This ebuild replaces rdoc in ruby-1.9.2 and later.
# ruby 1.8.6 is no longer supported.
RDEPEND="${RDEPEND}
	ruby_targets_ruby19? (
		>=dev-lang/ruby-1.9.2:1.9
	)
	ruby_targets_ruby18? (
		>=dev-lang/ruby-1.8.7:1.8
	)"

all_ruby_prepare() {
	# Other packages also have use for a nonexistent directory, bug 321059
	sed -i -e 's#/nonexistent#/nonexistent_rdoc_tests#g' test/test_rdoc*.rb || die

	# Remove unavailable and unneeded isolate plugin for Hoe
	sed -i -e '/isolate/d' Rakefile || die

	epatch "${FILESDIR}/${PN}-3.0.1-bin-require.patch"

	# Remove test that is depending on the locale, which we can't garantuee.
	sed -i -e '/def test_encode_with/,/^  end/ s:^:#:' test/test_rdoc_options.rb || die
}

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# Remove tests that will fail due to a bug in JRuby affecting
			# Dir.mktmpdir: http://jira.codehaus.org/browse/JRUBY-4082
			rm test/test_rdoc_options.rb || die
			;;
		*)
			;;
	esac
}

all_ruby_install() {
	all_fakegem_install

	for bin in rdoc ri; do
		ruby_fakegem_binwrapper $bin /usr/bin/$bin-2

		if use ruby_targets_ruby19; then
			ruby_fakegem_binwrapper $bin /usr/bin/${bin}19
			sed -i -e "1s/env ruby/ruby19/" \
				"${ED}/usr/bin/${bin}19" || die
		fi
	done
}
