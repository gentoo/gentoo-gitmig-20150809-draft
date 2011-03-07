# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdoc/rdoc-2.5.11.ebuild,v 1.7 2011/03/07 12:14:11 armin76 Exp $

EAPI=3
USE_RUBY="ruby18 ree18 jruby"

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
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	doc? ( >=dev-ruby/hoe-2.5.0 )
	test? (
		>=dev-ruby/hoe-2.5.0
		dev-ruby/minitest
	)"

all_ruby_prepare() {
	# Other packages also have use for a nonexistent directory, bug 321059
	sed -i -e 's#/nonexistent#/nonexistent_rdoc_tests#g' test/test_rdoc*.rb
}

all_ruby_install() {
	all_fakegem_install

	for bin in rdoc ri; do
		ruby_fakegem_binwrapper $bin /usr/bin/$bin-2
	done
}
