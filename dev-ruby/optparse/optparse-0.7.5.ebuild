# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/optparse/optparse-0.7.5.ebuild,v 1.1 2000/11/17 08:22:04 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Yet another option parser for Ruby"
SRC_URI=" http://member.nifty.ne.jp/nokada/archive/${A}"
HOMEPAGE=" http://member.nifty.ne.jp/nokada/ruby.html"

DEPEND=">=dev-lang/ruby-1.6.1"

#src_compile() {
#    cd ${S}
#    try ruby setup.rb config --without=amstd
#    try ruby setup.rb setup
#}

src_install () {
    cd ${S}
    insinto /usr/lib/ruby/site_ruby/1.6
    doins optparse.rb

    insinto /usr/lib/ruby/site_ruby/1.6/optparse
    doins optparse/*
}
