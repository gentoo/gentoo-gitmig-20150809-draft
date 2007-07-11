# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/podcast/podcast-0.0.4.ebuild,v 1.4 2007/07/11 05:23:08 mr_bones_ Exp $

inherit ruby gems

DESCRIPTION="A pure Ruby library for generating podcasts from mp3 files"
HOMEPAGE="http://podcast.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"

IUSE=""
USE_RUBY="any"
DEPEND="virtual/ruby dev-ruby/ruby-mp3info"
