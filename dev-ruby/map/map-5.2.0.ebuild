# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/map/map-5.2.0.ebuild,v 1.2 2012/01/31 18:20:14 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README TODO"

RUBY_FAKEGEM_GEMSPEC="map.gemspec"

inherit ruby-fakegem

DESCRIPTION="A string/symbol indifferent ordered hash that works in all rubies."
HOMEPAGE="http://github.com/ahoward/map"

LICENSE="|| ( Ruby BSD-2 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
