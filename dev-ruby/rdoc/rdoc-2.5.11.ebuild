# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdoc/rdoc-2.5.11.ebuild,v 1.1 2010/08/24 18:12:07 a3li Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt RI.txt"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem eutils

DESCRIPTION="An extended version of the RDoc library from Ruby 1.8"
HOMEPAGE="http://rubyforge.org/projects/rdoc/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	doc? ( >=dev-ruby/hoe-2.5.0 )
	test? (
		>=dev-ruby/hoe-2.5.0
		dev-ruby/minitest
	)"

# This ebuild replaces rdoc in ruby-1.9.2 and later
RDEPEND="${RDEPEND}
	ruby_targets_ruby19? (
		>=dev-lang/ruby-1.9.2
	)"

all_ruby_prepare() {
	# Other packages also have use for a nonexistent directory, bug 321059
	sed -i -e 's#/nonexistent#/nonexistent_rdoc_tests#g' test/test_rdoc*.rb
}

all_ruby_install() {
	all_fakegem_install

	for bin in rdoc ri; do
		ruby_fakegem_binwrapper $bin /usr/bin/$bin-2

		if use ruby_targets_ruby19; then
			ruby_fakegem_binwrapper $bin /usr/bin/${bin}19
			sed -i -e "1s/env ruby/ruby19/" \
				"${D}/usr/bin/${bin}19" || die
		fi
	done
}
