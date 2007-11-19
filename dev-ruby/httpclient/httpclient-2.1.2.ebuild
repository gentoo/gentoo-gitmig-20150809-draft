# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/httpclient/httpclient-2.1.2.ebuild,v 1.1 2007/11/19 19:51:32 flameeyes Exp $

inherit ruby

DESCRIPTION="'httpclient' gives something like the functionality of libwww-perl (LWP) in Ruby"
HOMEPAGE="http://dev.ctor.org/http-access2/"
SRC_URI="http://dev.ctor.org/download/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""
USE_RUBY="any"

S="${WORKDIR}/${P}"

RDEPEND="!dev-ruby/http-access2"

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
