# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rexml/rexml-2.5.8.ebuild,v 1.5 2004/04/10 22:31:24 dholm Exp $

MY_P="${PN}_${PV}"
DESCRIPTION="An XML parser for Ruby, in Ruby"
HOMEPAGE="http://www.germane-software.com/software/rexml"
SRC_URI="http://www.germane-software.com/archives/${MY_P}.tgz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha hppa mips sparc x86 ~ppc"
DEPEND="virtual/ruby"
S=${WORKDIR}/${MY_P}

src_install() {
	ruby bin/install.rb --destdir=${D} || die
	dodoc README
	# Use insinto/doins to avoid compressing html files
	insinto /usr/share/doc/${P}
	doins *.html
	dohtml -r doc/*
}
