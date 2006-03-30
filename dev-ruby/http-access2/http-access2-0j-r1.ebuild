# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/http-access2/http-access2-0j-r1.ebuild,v 1.4 2006/03/30 03:30:30 agriffis Exp $

inherit ruby

MY_PV=${PV/0/}
MY_P=${PN}-${MY_PV}
DESCRIPTION="HTTP accessing library"
HOMEPAGE="http://rrr.jin.gr.jp/doc/http-access2/"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/contrib/${MY_P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ppc x86"
IUSE=""
USE_RUBY="any"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s%^DSTPATH = %DSTPATH = \"${D}\" + %" install.rb
}
