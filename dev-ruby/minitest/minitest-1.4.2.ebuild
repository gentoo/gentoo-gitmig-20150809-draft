# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/minitest/minitest-1.4.2.ebuild,v 1.1 2009/12/14 19:06:35 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

RUBY_FAKEGEM_EXTRAINSTALL="template"

inherit ruby-fakegem

ruby_add_bdepend test virtual/ruby-test-unit

DESCRIPTION="Hoe extends rake to provide full project automation."
HOMEPAGE="http://seattlerb.rubyforge.org/"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""


