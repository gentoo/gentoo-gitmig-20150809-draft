# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/raggle/raggle-0.3.1.ebuild,v 1.6 2005/01/04 15:47:14 citizen428 Exp $

inherit ruby

DESCRIPTION="A console RSS aggregator, written in Ruby"
HOMEPAGE="http://www.raggle.org/"
SRC_URI="http://www.raggle.org/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~sparc ~mips alpha ~hppa ~amd64 ~ppc"
IUSE=""
USE_RUBY="any"
DEPEND="virtual/ruby"
RDEPEND=">=dev-ruby/ncurses-ruby-0.8"

PATCHES="${FILESDIR}/${PN}-destdir-gentoo.diff"

