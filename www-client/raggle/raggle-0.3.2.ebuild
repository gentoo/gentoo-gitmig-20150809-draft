# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/raggle/raggle-0.3.2.ebuild,v 1.1 2004/12/01 21:00:29 citizen428 Exp $

inherit ruby

DESCRIPTION="A console RSS aggregator, written in Ruby"
HOMEPAGE="http://www.raggle.org/"
SRC_URI="http://www.raggle.org/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~alpha ~hppa ~amd64 ~ppc"
IUSE=""
# ruby16 currently not supported because of a missing dependancy
USE_RUBY="ruby18 ruby19"
DEPEND="|| ( >=dev-lang/ruby-1.8
	dev-lang/ruby-cvs)"
RDEPEND=">=dev-ruby/ncurses-ruby-0.8"

PATCHES="${FILESDIR}/${PN}-destdir-gentoo.diff"

