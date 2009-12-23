# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/minitest/minitest-1.4.2.ebuild,v 1.6 2009/12/23 13:25:56 jer Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

RUBY_FAKEGEM_EXTRAINSTALL="template"

inherit ruby-fakegem

DESCRIPTION="minitest/unit is a small and fast replacement for ruby's huge and slow test/unit."
HOMEPAGE="http://rubyforge.org/projects/bfts"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc"
IUSE=""

ruby_add_bdepend test "virtual/ruby-test-unit dev-ruby/hoe"
