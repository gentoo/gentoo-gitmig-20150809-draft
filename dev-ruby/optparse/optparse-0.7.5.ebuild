# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/optparse/optparse-0.7.5.ebuild,v 1.5 2002/08/01 11:59:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Yet another option parser for Ruby"
SRC_URI=" http://member.nifty.ne.jp/nokada/archive/${P}.tar.gz"
HOMEPAGE=" http://member.nifty.ne.jp/nokada/ruby.html"
LICENSE="Ruby"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.6.1"

#src_compile() {
#    ruby setup.rb config --without=amstd || die
#    ruby setup.rb setup || die
#}

src_install () {
	insinto /usr/lib/ruby/site_ruby/1.6
	doins optparse.rb

	insinto /usr/lib/ruby/site_ruby/1.6/optparse
	doins optparse/*
}
