# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-liquid/ruby-liquid-1.0.ebuild,v 1.2 2006/12/08 17:43:24 pclouds Exp $

inherit ruby

MY_P="${P/ruby-/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Template engine for Ruby"
HOMEPAGE="http://home.leetsoft.com/liquid"
SRC_URI="http://dist.leetsoft.com/pkg/${MY_P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd ~x86"
IUSE=""

USE_RUBY="ruby18 ruby19"

src_install() {
	local sitelibdir
	sitelibdir=`${RUBY} -rrbconfig -e 'puts Config::CONFIG["sitelibdir"]'`
	insinto "$sitelibdir"
	doins "${S}/lib/liquid.rb"
	insinto "$sitelibdir/liquid"
	doins "${S}/lib/liquid/"*.rb

	erubydoc
}
