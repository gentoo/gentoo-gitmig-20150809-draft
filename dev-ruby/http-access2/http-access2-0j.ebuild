# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/http-access2/http-access2-0j.ebuild,v 1.7 2004/06/25 01:53:47 agriffis Exp $

MY_PV=${PV/0/}
MY_P=${PN}-${MY_PV}
DESCRIPTION="HTTP accessing library"
HOMEPAGE="http://rrr.jin.gr.jp/doc/http-access2/"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/contrib/${MY_P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/ruby"
S=${WORKDIR}/${MY_P}

src_install() {
	local sitelibdir=`ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]'`
	insinto ${sitelibdir}
	doins lib/*.rb
	insinto ${sitelibdir}/http-access2
	doins lib/http-access2/*.rb
}
