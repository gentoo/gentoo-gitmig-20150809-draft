# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/optparse/optparse-0.10.1.ebuild,v 1.4 2003/07/12 13:03:10 aliz Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Yet another option parser for Ruby"
SRC_URI=" http://member.nifty.ne.jp/nokada/archive/${P}.tar.gz"
HOMEPAGE=" http://member.nifty.ne.jp/nokada/ruby.html"
LICENSE="Ruby"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.6.1"

src_install () {
	insinto /usr/lib/ruby/site_ruby/1.6
	doins optparse.rb

	insinto /usr/lib/ruby/site_ruby/1.6/optparse
	doins optparse/*

	#docs
	dodoc ChangeLog README.en
	dohtml *.html
}
