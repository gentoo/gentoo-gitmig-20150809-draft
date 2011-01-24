# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cerberus/cerberus-0.7.8-r1.ebuild,v 1.1 2011/01/24 18:38:31 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="Authors.txt Changelog.txt Readme.markdown"

inherit ruby-fakegem

DESCRIPTION="Continuous Integration tool for ruby projects"
HOMEPAGE="http://rubyforge.org/projects/cerberus"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

# The json dependency is indirect via the vendored twitter code.
ruby_add_rdepend "=dev-ruby/actionmailer-2*
	=dev-ruby/activesupport-2*
	>=dev-ruby/rake-0.7.3
	dev-ruby/json"

ruby_add_bdepend "test? ( virtual/ruby-test-unit dev-ruby/rubyzip )"

DEPEND="${DEPEND} test? ( dev-vcs/subversion )"
RDEPEND="${RDEPEND}"

# TODO: cerberus bundles several packages: addressable, shout-bot,
# tinder, twitter, and xmpp4r. Some of these are very
# version-dependant, so it is not easy to determine whether they can
# be unbundeled.

RUBY_PATCHES=( "${FILESDIR}"/${P}-rails3.patch )
