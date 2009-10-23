# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-liquid/ruby-liquid-1.0.ebuild,v 1.3 2009/10/23 14:29:59 graaff Exp $

inherit ruby

MY_P="${P/ruby-/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Template engine for Ruby"
HOMEPAGE="http://www.liquidmarkup.org/"
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
