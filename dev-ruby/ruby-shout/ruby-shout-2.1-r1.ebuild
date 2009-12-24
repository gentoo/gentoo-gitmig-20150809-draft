# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-shout/ruby-shout-2.1-r1.ebuild,v 1.3 2009/12/24 17:12:49 graaff Exp $

inherit gems

DESCRIPTION="A Ruby interface to libshout2"
HOMEPAGE="http://ruby-shout.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=media-libs/libshout-2.0"
DEPEND="${RDEPEND}"

USE_RUBY="ruby18"
