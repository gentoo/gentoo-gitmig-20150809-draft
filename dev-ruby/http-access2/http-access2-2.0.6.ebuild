# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/http-access2/http-access2-2.0.6.ebuild,v 1.2 2007/01/06 16:02:34 flameeyes Exp $

inherit ruby

MY_PV=${PV//./_}
MY_PN=${PN/2}
MY_P=${MY_PN}-${MY_PV}
DESCRIPTION="'http-access2' gives something like the functionality of libwww-perl (LWP) in Ruby"
HOMEPAGE="http://dev.ctor.org/http-access2/"
SRC_URI="http://dev.ctor.org/download/${MY_P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86 ~x86-fbsd"
IUSE=""
USE_RUBY="any"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s%^SITELIBDIR = %SITELIBDIR = \"${D}\" + %" install.rb
}

src_compile() { :; }

src_install() {
	my_sitedir=$(ruby -rrbconfig -e 'print Config::CONFIG["sitedir"]')
	mkdir -p "${D}/${my_sitedir}/1.8"
	ruby install.rb
	erubydoc
}
