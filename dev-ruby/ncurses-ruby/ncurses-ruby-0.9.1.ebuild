# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ncurses-ruby/ncurses-ruby-0.9.1.ebuild,v 1.8 2008/05/02 18:56:59 pythonhead Exp $

RUBY_BUG_145222=yes
inherit ruby

DESCRIPTION="Ruby wrappers of ncurses and PDCurses libs"
HOMEPAGE="http://ncurses-ruby.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"
KEYWORDS="alpha amd64 ~hppa ~mips ppc sparc x86"
IUSE="examples"
DEPEND="virtual/ruby
	>=sys-libs/ncurses-5.3"
