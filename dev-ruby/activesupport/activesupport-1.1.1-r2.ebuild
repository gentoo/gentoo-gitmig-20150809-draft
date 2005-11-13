# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-1.1.1-r2.ebuild,v 1.2 2005/11/13 22:51:27 weeve Exp $

inherit ruby gems eutils

USE_RUBY="ruby18"
DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/5160/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/rubygems-0.8.10"

src_install() {
	gems_src_install
	cd ${D}/${GEMSDIR}/gems
	patch -p0 < ${FILESDIR}/clean_logger-format_message-fix.patch
}
