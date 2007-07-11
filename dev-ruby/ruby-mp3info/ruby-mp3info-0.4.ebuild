# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-mp3info/ruby-mp3info-0.4.ebuild,v 1.2 2007/07/11 05:23:08 mr_bones_ Exp $

inherit ruby

DESCRIPTION="A pure Ruby library for access to mp3 files (internal infos and tags)"
HOMEPAGE="http://rubyforge.org/projects/ruby-mp3info/"
SRC_URI="http://rubyforge.org/frs/download.php/4278/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""
USE_RUBY="any"
DEPEND="virtual/ruby"

src_test() {
	ruby test.rb || die "test.rb failed"
}
