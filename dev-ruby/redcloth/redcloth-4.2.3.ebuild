# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/redcloth/redcloth-4.2.3.ebuild,v 1.5 2010/08/01 19:09:40 hwoarang Exp $

EAPI=2

# jruby → tests still fail with UTF-8 characters
USE_RUBY="ruby18"

RUBY_FAKEGEM_NAME="RedCloth"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="README CHANGELOG"

RUBY_FAKEGEM_REQUIRE_PATHS="lib/case_sensitive_require"

inherit ruby-fakegem versionator

DESCRIPTION="A module for using Textile in Ruby"
HOMEPAGE="http://redcloth.org/"

SRC_URI="http://github.com/jgarber/redcloth/tarball/RELEASE_$(replace_all_version_separators _) -> ${RUBY_FAKEGEM_NAME}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="$DEPEND
	dev-util/ragel"
RDEPEND="$RDEPEND"

S="${WORKDIR}/jgarber-${PN}-*"

ruby_add_bdepend "
	dev-ruby/rake
	>=dev-ruby/echoe-3.0.1
	test? (
		dev-ruby/rspec
		dev-ruby/diff-lcs
	)"

pkg_setup() {
	# Export the VERBOSE variable to avoid remapping of stdout and
	# stderr, and that breaks because of bad interactions between
	# echoe, Ruby and Gentoo.
	export VERBOSE=1
}

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

each_ruby_compile() {
	# We cannot run this manually easily, because Ragel re-generation
	# is a mess
	${RUBY} -S rake compile || die "rake compile failed"
}

each_ruby_test() {
	find spec -name '*_spec.rb' -print0 | xargs -0 ${RUBY} -I lib -S spec -Du -fs
}
