# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/racc/racc-1.4.4.ebuild,v 1.16 2007/04/14 06:08:44 graaff Exp $

inherit ruby

MY_P=${P}-all
DESCRIPTION="A LALR(1) parser generator for Ruby"
HOMEPAGE="http://www.loveruby.net/en/racc.html"
SRC_URI="http://www.loveruby.net/archive/racc/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 mips ppc ~ppc-macos sparc x86"
USE_RUBY="ruby18 ruby19"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND=">=dev-lang/ruby-1.8"
