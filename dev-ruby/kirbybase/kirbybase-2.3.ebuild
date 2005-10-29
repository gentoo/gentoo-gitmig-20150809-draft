# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kirbybase/kirbybase-2.3.ebuild,v 1.1 2005/10/29 15:49:10 citizen428 Exp $

inherit ruby

IUSE=""

MY_P="KirbyBase_Ruby_${PV}"

DESCRIPTION="A simple, pure-Ruby, flat-file database management system"
HOMEPAGE="http://www.netpromi.com/kirbybase_ruby.html"
SRC_URI="http://www.netpromi.com/files/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/ruby"
USE_RUBY="ruby18"

S=${WORKDIR}/${P/-/}

src_compile() {
	return
}

src_install() {
	local sitelibdir=`${RUBY} -r rbconfig -e 'puts Config::CONFIG["sitelibdir"]'`
	insinto ${sitelibdir}
	doins kirbybase.rb kbserver.rb
	dodoc changes.txt readme.txt
	dohtml -r kirbybaserubymanual.html doc/*
	cp -r examples ${D}/usr/share/doc/${PF}/examples
}
