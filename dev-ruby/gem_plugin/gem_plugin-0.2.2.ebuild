# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gem_plugin/gem_plugin-0.2.2.ebuild,v 1.1 2007/01/04 13:35:15 pclouds Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A plugin system based only on rubygems that uses dependencies only."
# Mongrel hosts gem_plugin, so setting that as homepage
HOMEPAGE="http://mongrel.rubyforge.org/"
SRC_URI="http://mongrel.rubyforge.org/releases/gems/${P}.gem"

LICENSE="mongrel"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-ruby/rake-0.7"
