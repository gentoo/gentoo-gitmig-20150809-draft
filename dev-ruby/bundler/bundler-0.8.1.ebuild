# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bundler/bundler-0.8.1.ebuild,v 1.3 2010/05/01 00:40:38 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="spec"

# No documentation task
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

inherit ruby-fakegem

DESCRIPTION="An easy way to vendor gem dependencies"
HOMEPAGE="http://github.com/wycats/bundler"

GITHUB_USER="wycats"
# Untagged, but should correspond to 0.8.1 release
TREE_HASH="db101cc631de7784267f87c67f33a695d2b9db26"

SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/${TREE_HASH} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/${GITHUB_USER}-${PN}-${TREE_HASH:0:7}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# does not work with the reduced interface provided by Ruby 1.9 and
# JRuby, so it needs the full package
ruby_add_rdepend dev-ruby/rubygems

ruby_add_bdepend test dev-ruby/rspec
