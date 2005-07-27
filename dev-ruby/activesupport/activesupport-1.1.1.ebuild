# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-1.1.1.ebuild,v 1.3 2005/07/27 13:01:30 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/5160/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/rubygems-0.8.10"
