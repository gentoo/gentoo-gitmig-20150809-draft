# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/subexec/subexec-0.1.0.ebuild,v 1.1 2011/03/04 16:21:49 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem eutils

GITHUB_USER="nulayer"
PV_COMMIT="84b4e1063ef6ae7e0acfd89427587b8a2cf4d7db"

DESCRIPTION="Subexec spawns an external command with a timeout"
HOMEPAGE="http://github.com/nulayer/subexec"
SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/${PV_COMMIT} -> ${PN}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${GITHUB_USER}-${PN}-*"

ruby_add_bdepend "test? ( dev-ruby/ruby-debug dev-ruby/shoulda )"
