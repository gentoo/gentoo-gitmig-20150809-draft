# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-shout/ruby-shout-2.1-r1.ebuild,v 1.2 2008/11/22 15:25:41 maekke Exp $

inherit gems

DESCRIPTION="A Ruby interface to libshout2"
HOMEPAGE="http://ruby-shout.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/ruby
	>=media-libs/libshout-2.0"

USE_RUBY="ruby18"
