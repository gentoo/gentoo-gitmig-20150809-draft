# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bundler/bundler-0.9.26.ebuild,v 1.2 2010/06/30 12:05:31 flameeyes Exp $

EAPI=2

# ruby19 → uncountable number of test failures
# jruby → needs to be tested because jruby-1.5.1 fails in multiple
# ways unrelated to this package
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

# No documentation task
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md ROADMAP.md"

inherit ruby-fakegem

DESCRIPTION="An easy way to vendor gem dependencies"
HOMEPAGE="http://github.com/carlhuda/bundler"

GITHUB_USER="carlhuda"
SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/${PV} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/${GITHUB_USER}-${PN}-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend dev-ruby/rubygems

ruby_add_bdepend "test? ( dev-ruby/rspec )"

RDEPEND="${RDEPEND}
	dev-vcs/git"
DEPEND="${DEPEND}
	test? ( dev-vcs/git )"

RUBY_PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )
