# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/devel-logger/devel-logger-1.0.1-r1.ebuild,v 1.1 2004/04/10 08:38:56 usata Exp $

inherit ruby

MY_P=${PN}-${PV//./_}
DESCRIPTION="Lightweight logging utility"
HOMEPAGE="http://rrr.jin.gr.jp/doc/devel-logger/"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/contrib/${MY_P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha hppa mips sparc x86"
IUSE=""
DEPEND="virtual/ruby"
USE_RUBY="any"
S=${WORKDIR}/${MY_P}

src_compile() {
	return
}

src_install() {
	cp install.rb install.rb.orig
	sed -e "s:^DSTPATH = :DSTPATH = \"${D}\" + \"/\" + :" install.rb.orig > install.rb
	ruby install.rb || die
}
