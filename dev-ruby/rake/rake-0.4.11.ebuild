# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rake/rake-0.4.11.ebuild,v 1.2 2004/12/30 10:58:44 nigoro Exp $

inherit ruby

DESCRIPTION="Make-like scripting in Ruby"
HOMEPAGE="http://rake.rubyforge.org/"
LICENSE="MIT"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/1885/${P}.tgz"

USE_RUBY="ruby18 ruby19"  # requires 1.8.0 or later
KEYWORDS="~x86 ~ppc ~ppc64"

SLOT="0"
IUSE=""

src_compile() {
	return
}

src_install() {
	DESTDIR="$D" ruby install.rb || die
}

src_test() {
	#in order to run src_test, rake must be installed beforehand
	if has_version 'dev-ruby/rake' ; then
		rake || die "src_test failed"
	fi
}
