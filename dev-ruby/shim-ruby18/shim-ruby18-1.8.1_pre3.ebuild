# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shim-ruby18/shim-ruby18-1.8.1_pre3.ebuild,v 1.2 2004/01/25 16:12:00 usata Exp $

inherit ruby

MY_P="shim-ruby16_18-${PV/_pre/-preview}"

DESCRIPTION="Set of packages that provide Ruby 1.8 features for Ruby 1.6"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=shim-ruby16_18"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/shim/${MY_P}.tar.bz2"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"

IUSE=""
# don't define USE_RUBY since shim-ruby only supports ruby16
RUBY="/usr/bin/ruby16"

DEPEND="~dev-lang/ruby-1.6.8"
PROVIDE="dev-ruby/strscan
	dev-ruby/racc
	dev-ruby/optparse"

S="${WORKDIR}/shim/ruby16"

src_install() {

	einstall || die
	erubydoc
	dodoc ${WORKDIR}/shim/README
}
