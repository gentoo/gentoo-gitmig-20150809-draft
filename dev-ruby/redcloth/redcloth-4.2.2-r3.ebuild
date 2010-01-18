# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/redcloth/redcloth-4.2.2-r3.ebuild,v 1.3 2010/01/18 20:34:00 ranger Exp $

EAPI=2

# jruby → released tarballs and gems don't have support for it so we
# have to use the git snapshots, on the other hand, it doesn't seem to
# build fine right now, so we're probably going to wait for next
# release.
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
SRC_URI="http://github.com/Flameeyes/redcloth/tarball/9e1025baf6bde57658d6794ec792e406444b4f7c -> ${RUBY_FAKEGEM_NAME}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-util/ragel"
RDEPEND=""

# Yes this is a snapshot from my own repository, let's just keep it at
# this for now.
S="${WORKDIR}/Flameeyes-redcloth-9e1025b"

# rspec is needed for the Rakefile to work if not patched; should
# probably be reported upstream to fix
ruby_add_bdepend '>=dev-ruby/echoe-3.0.1 dev-ruby/rspec'

ruby_add_bdepend test "dev-ruby/diff-lcs"

all_ruby_prepare() {
	# We need to do this to avoid re-compilation when running tests
	sed -i \
		-e '/task :spec/s|, :compile||' \
		Rakefile || die "Rakefile fixes failed"
}

each_ruby_compile() {
	${RUBY} -S rake compile || die "build failed"
}
