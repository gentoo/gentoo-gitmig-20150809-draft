# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shotgun/shotgun-0.5.ebuild,v 1.1 2010/01/25 18:55:56 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18"

# No documentation task
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Forking implementation of rackup"
HOMEPAGE="http://rtomayko.github.com/shotgun/"

GITHUB_USER="rtomayko"
# Untagged, but should correspond to 0.5 release
TREE_HASH="91f76ba3a75a22f60121b1403881aec70f35d75f"

SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/${TREE_HASH} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/${GITHUB_USER}-${PN}-${TREE_HASH:0:7}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# Warning: the code does not use gem versioning to make sure to load
# only the right rack version so we might need to patch it to work :/
# Has a runtime dependency over launchy, but it's not striclty needed,
# so we'll patch it and announce its possible requirement.
ruby_add_rdepend '=dev-ruby/rack-1.0*'
ruby_add_bdepend test dev-ruby/bacon

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-optional-launchy.patch
}

pkg_postinst() {
	elog "${PN} can also launch your browser at startup, but to do so it needs"
	elog "the dev-ruby/launchy package that is currently available just on the Ruby"
	elog "project's overlay for dependency/license issues."
}
