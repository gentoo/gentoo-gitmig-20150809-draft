# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/raggle/raggle-0.3.1.ebuild,v 1.2 2004/07/08 23:54:33 mr_bones_ Exp $

inherit ruby

DESCRIPTION="A console RSS aggregator, written in Ruby"
HOMEPAGE="http://www.raggle.org/"
SRC_URI="http://www.raggle.org/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~alpha ~hppa"
IUSE=""
USE_RUBY="any"
DEPEND="virtual/ruby"
RDEPEND=">=dev-ruby/ncurses-ruby-0.8"

PATCHES="${FILESDIR}/${PN}-destdir-gentoo.diff"

