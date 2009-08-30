# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/deprecated/deprecated-2.0.1.ebuild,v 1.4 2009/08/30 09:49:02 a3li Exp $

EAPI="2"
inherit ruby
USE_RUBY="ruby18 ruby19"

DESCRIPTION="A Ruby library for handling deprecated code"
HOMEPAGE="http://rubyforge.org/projects/deprecated"
SRC_URI="mirror://rubyforge/deprecated/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-ruby/test-unit )
	${RDEPEND}"
RDEPEND="dev-lang/ruby"

src_test() {
	for rb in $USE_RUBY; do
		[ -n "$(type -p ${rb})" ] || continue
		ebegin "Testing for ${rb}"
		${rb} setup.rb test || die "test failed"
		eend $?
	done
}

src_install() {
	ruby setup.rb install --prefix="${D}" || die "setup.rb install failed"
}
