# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubygems/rubygems-0.8.11-r3.ebuild,v 1.2 2006/02/22 18:17:17 caleb Exp $

inherit ruby

DESCRIPTION="Centralized Ruby extension management system"
HOMEPAGE="http://rubyforge.org/projects/rubygems/"
LICENSE="Ruby"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/5207/${P}.tgz"

KEYWORDS="~amd64 ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
SLOT="0"
IUSE=""
DEPEND=">=dev-lang/ruby-1.8
	>=dev-ruby/ruby-config-0.3.2"

PATCHES="${FILESDIR}/no_post_install.patch"
USE_RUBY="ruby18"

src_compile() {
	return
}

src_install() {
	ver=$(${RUBY} -r rbconfig -e 'print Config::CONFIG["MAJOR"] + "." + Config::CONFIG["MINOR"]')
	GEM_HOME=${D}/usr/lib/ruby/gems/$ver ruby_src_install
	keepdir /usr/lib/ruby/gems/$ver/doc
}
