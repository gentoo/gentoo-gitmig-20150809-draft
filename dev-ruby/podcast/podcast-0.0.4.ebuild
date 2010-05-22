# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/podcast/podcast-0.0.4.ebuild,v 1.7 2010/05/22 15:35:34 flameeyes Exp $

inherit ruby gems

DESCRIPTION="A pure Ruby library for generating podcasts from mp3 files"
HOMEPAGE="http://podcast.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"

IUSE=""
USE_RUBY="ruby18"
DEPEND="dev-ruby/ruby-mp3info"
