# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ncurses-ruby/ncurses-ruby-0.8.ebuild,v 1.5 2003/11/16 19:27:24 usata Exp $

inherit ruby

DESCRIPTION="Ruby wrappers of ncurses and PDCurses libs"
HOMEPAGE="http://ncurses-ruby.berlios.de/"
SRC_URI="http://download.berlios.de/ncurses-ruby/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
USE_RUBY="ruby16 ruby18"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.6
	>=sys-libs/ncurses-5.3"
