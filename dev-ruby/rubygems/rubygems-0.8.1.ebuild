# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubygems/rubygems-0.8.1.ebuild,v 1.1 2004/11/19 20:50:48 usata Exp $

inherit ruby

DESCRIPTION="Centralized Ruby extension management system"
HOMEPAGE="http://rubyforge.org/projects/rubygems/"
LICENSE="Ruby"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/1399/${P}.tgz"

KEYWORDS="~x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18 ruby19"
DEPEND="virtual/ruby"
PATCHES="${FILESDIR}/${P}-gentoo.diff"

src_compile() {
	return
}
