# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/refe/refe-0.8.0.ebuild,v 1.2 2004/03/13 19:44:25 usata Exp $

inherit ruby

IUSE=""

DESCRIPTION="ReFe is an interactive reference for Japanese Ruby manual"
HOMEPAGE="http://www.loveruby.net/ja/prog/refe.html"
SRC_URI="http://www.loveruby.net/archive/refe/${P}-withdoc.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
USE_RUBY="any"

src_compile() {

	erubyconf || die
	# do not run make for this package
}

src_install() {

	erubyinstall || die

	erubydoc
}
