# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/map/map-4.6.1.ebuild,v 1.1 2011/10/11 05:46:42 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README TODO"

inherit ruby-fakegem

DESCRIPTION="A string/symbol indifferent ordered hash that works in all rubies."
HOMEPAGE="http://github.com/ahoward/map"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
