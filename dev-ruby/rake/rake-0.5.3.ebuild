# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rake/rake-0.5.3.ebuild,v 1.5 2005/08/01 18:49:15 fmccor Exp $

inherit ruby gems

USE_RUBY="ruby18 ruby19"
DESCRIPTION="Make-like scripting in Ruby"
HOMEPAGE="http://rake.rubyforge.org/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/3875/${P}.gem
	http://rubyforge.org/frs/download.php/3876/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""
RESTRICT="test"

src_unpack() {
	gems_src_unpack
	unpack ${P}.tgz
}

src_install() {
	#We install both sitelib and gem versions:
	gems_src_install
	cd ${WORKDIR}/${P}
	DESTDIR="$D" ruby install.rb || die
}
