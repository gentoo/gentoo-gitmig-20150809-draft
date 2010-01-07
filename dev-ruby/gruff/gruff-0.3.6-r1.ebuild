# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gruff/gruff-0.3.6-r1.ebuild,v 1.1 2010/01/07 07:28:48 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

RUBY_FAKEGEM_EXTRAINSTALL="assets rails_generators"

inherit ruby-fakegem

ruby_add_rdepend '>=dev-ruby/rmagick-2'
ruby_add_bdepend test "dev-ruby/hoe virtual/ruby-test-unit"
ruby_add_bdepend doc dev-ruby/hoe

DESCRIPTION="RMagick Implementation for JRuby"
HOMEPAGE="http://rubyforge.org/projects/gruff/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RUBY_PATCHES=(
	${P}-sort-filenames.patch
	${P}-fix-tests.patch
	${P}-spider.patch
)
