# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/optparse/optparse-0.12.ebuild,v 1.1 2003/06/10 19:26:30 twp Exp $

DESCRIPTION="An option parser"
HOMEPAGE="http://member.nifty.ne.jp/nokada/ruby.html"
SRC_URI="http://member.nifty.ne.jp/nokada/archive/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha arm hppa mips sparc x86"
DEPEND=">=dev-lang/ruby-1.6 <dev-lang/ruby-1.8"

src_install() {
	ruby install.rb --prefix=${D} --man-install=/usr/share/man --doc-install=/usr/share/doc/${PF}
}
