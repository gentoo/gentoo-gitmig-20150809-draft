# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-mp3info/ruby-mp3info-0.3.ebuild,v 1.1 2005/02/15 17:22:24 citizen428 Exp $

inherit ruby

DESCRIPTION="A pure Ruby library for access to mp3 files (internal infos and tags)"
HOMEPAGE="http://rubyforge.org/projects/ruby-mp3info/"
SRC_URI="http://rubyforge.org/frs/download.php/808/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
USE_RUBY="any"
DEPEND="virtual/ruby"
