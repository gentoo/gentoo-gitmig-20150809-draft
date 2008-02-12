# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/archive-tar-minitar/archive-tar-minitar-0.5.1.ebuild,v 1.2 2008/02/12 18:42:56 opfer Exp $

inherit gems

USE_RUBY="ruby18"
DESCRIPTION="Provides POSIX tarchive management from Ruby programs."
HOMEPAGE="http://rubyforge.org/projects/ruwiki/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test"
