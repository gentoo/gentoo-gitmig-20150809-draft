# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/redcloth/redcloth-4.2.2-r2.ebuild,v 1.1 2009/12/26 17:07:30 flameeyes Exp $

EAPI=2

# jruby → should be supported, but since we don't have the Ragel files
#         in the tarball, we cannot generate the Java files (also nt
#         in the tarball).
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_NAME="RedCloth"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="README CHANGELOG"

RUBY_FAKEGEM_REQUIRE_PATHS="lib/case_sensitive_require"

inherit ruby-fakegem

DESCRIPTION="A module for using Textile in Ruby"
HOMEPAGE="http://redcloth.org/"
SRC_URI="mirror://rubyforge/redcloth/${RUBY_FAKEGEM_NAME}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${RUBY_FAKEGEM_NAME}-${PV}"

ruby_add_bdepend '>=dev-ruby/echoe-3.0.1'

ruby_add_bdepend test "dev-ruby/diff-lcs dev-ruby/rspec"

all_ruby_prepare() {
	sed -i \
		-e 's|Platform|Echoe::Platform|' \
		-e '/^# Ragel-generated/,/Optimization/ s:^:#:' \
		-e '/task :spec/s|, :compile||' \
		Rakefile || die "Rakefile fixes failed"
}

each_ruby_compile() {
	${RUBY} -S rake compile || die "build failed"
}
