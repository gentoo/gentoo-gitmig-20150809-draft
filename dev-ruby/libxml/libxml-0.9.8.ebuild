# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/libxml/libxml-0.9.8.ebuild,v 1.1 2009/01/25 15:14:15 flameeyes Exp $

inherit ruby

MY_P=${PN}-ruby-${PV}

DESCRIPTION="Ruby libxml with a user friendly API, akin to REXML, but feature complete and significantly faster."
HOMEPAGE="http://libxml.rubyforge.org"
SRC_URI="mirror://rubyforge/${PN}/${MY_P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/libxml2-2.6.6"
DEPEND="${RDEPEND}
	dev-ruby/rake"

S="${WORKDIR}/${MY_P}"

USE_RUBY="ruby18"

src_compile() {
	rake extensions || die "rake extensions failed"

	if use doc; then
		rake rdoc || die "rake rdoc failed"
	fi
}

src_test() {
	rake test || die "rake test failed"
}

src_install() {
	cd "${S}"/lib
	doruby -r * || die "doruby failed"

	cd "${S}"/ext/libxml
	ruby_einstall || die "ruby_einstall failed"

	cd "${S}"

	dodoc README CHANGES || die "dodoc failed"

	if use doc; then
		dohtml -r doc/* || die "dohtml failed"
	fi
}
