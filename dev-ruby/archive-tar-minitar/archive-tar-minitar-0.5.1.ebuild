# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/archive-tar-minitar/archive-tar-minitar-0.5.1.ebuild,v 1.3 2009/04/14 20:48:03 gentoofan23 Exp $

inherit gems

USE_RUBY="ruby18"
DESCRIPTION="Provides POSIX tarchive management from Ruby programs."
HOMEPAGE="http://rubyforge.org/projects/ruwiki/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""
RESTRICT="test"
