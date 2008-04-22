# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/id3lib-ruby/id3lib-ruby-0.5.0.ebuild,v 1.3 2008/04/22 18:08:21 armin76 Exp $

inherit ruby gems

DESCRIPTION="Ruby interface to the id3lib C++ library"
HOMEPAGE="http://id3lib-ruby.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

USE_RUBY="ruby18"
RDEPEND="media-libs/id3lib"
