# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tzinfo/tzinfo-0.3.13.ebuild,v 1.1 2009/04/17 12:02:39 flameeyes Exp $

inherit ruby

DESCRIPTION="Library to provide daylight-savings aware transformations between timezones"
HOMEPAGE="http://tzinfo.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="doc test"

RDEPEND=""
DEPEND="doc? ( dev-ruby/rake )
	test? ( dev-ruby/rake )"

USE_RUBY="ruby18"

src_unpack() {
	unpack ${A}

	# The package has all the files executable, probably coming from
	# Windows.
	find "${S}" -type f -perm +111 -exec chmod -x {} +

	# With rubygems 1.3.1 we get the following warning
	# warning: Insecure world writable dir /var/tmp in LOAD_PATH, mode 041777
	# when running the test_get_tainted_not_loaded test.
	[[ "${PV}" != "0.3.13" ]] && die "Hey you still got a 0.3.13-specific hack!"
	sed -i -e '138,146s:^:#:' "${S}"/test/tc_timezone.rb || die "unable to sed out the test"
}

src_compile() {
	if use doc; then
		rake rerdoc || die "rake rerdoc failed"
	fi
}

src_test() {
	rake test || die "rake test failed"
}

src_install() {
	cd "${S}"/lib
	doruby -r * || die "doruby failed"

	if use doc; then
		dohtml -r "${S}"/doc/* || die "dohtml failed"
	fi

	dodoc "${S}"/CHANGES "${S}"/README || die "dodoc failed"
}
