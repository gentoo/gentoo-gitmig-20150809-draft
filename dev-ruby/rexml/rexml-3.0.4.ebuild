# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rexml/rexml-3.0.4.ebuild,v 1.4 2004/10/25 21:58:17 slarti Exp $

inherit ruby

MY_P="${P/-/_}"
DESCRIPTION="An XML parser for Ruby, in Ruby"
HOMEPAGE="http://www.germane-software.com/software/rexml"
SRC_URI="http://www.germane-software.com/archives/${MY_P}.tgz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha ~hppa ~mips ~sparc ~x86 ~ppc ~amd64"
IUSE=""
USE_RUBY="any"
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
