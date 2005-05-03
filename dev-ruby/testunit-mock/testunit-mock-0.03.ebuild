# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/testunit-mock/testunit-mock-0.03.ebuild,v 1.1 2005/05/03 10:09:23 citizen428 Exp $

inherit ruby

MY_P="Test-Unit-Mock-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Mock objects for Ruby's Test::Unit"
HOMEPAGE="http://www.deveiate.org/code/Test-Unit-Mock.html"
SRC_URI="http://www.deveiate.org/code/${MY_P}.tar.bz2"

KEYWORDS="~x86"

USE_RUBY="ruby18 ruby19"
RDEPEND="dev-ruby/diff"

IUSE=""

# prevent ruby.eclass from using a broken install.rb
src_compile() {
	return
}

src_install() {
	local sitelibdir
	sitelibdir=`${RUBY} -rrbconfig -e 'puts Config::CONFIG["sitelibdir"]'`
	insinto "$sitelibdir/test/unit"
	doins mock.rb
	erubydoc
}

src_test() {
	ruby test.rb || "test.rb failed"
}
