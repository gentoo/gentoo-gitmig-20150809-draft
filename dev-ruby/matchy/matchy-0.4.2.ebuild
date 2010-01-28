# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/matchy/matchy-0.4.2.ebuild,v 1.1 2010/01/28 01:15:22 flameeyes Exp $

EAPI="2"

MY_OWNER="mcmire"

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_DOCDIR=""
RUBY_FAKEGEM_EXTRADOC=""

RUBY_FAKEGEM_NAME="${MY_OWNER}-${PN}"

inherit ruby-fakegem

DESCRIPTION="RSpec-esque matchers for use in Test::Unit"
HOMEPAGE="http://github.com/mcmire/matchy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_prepare() {
	# Don't force us to use Jeweler, disable check_dependency task
	# dependency.
	sed -i \
		-e '/check_dependencies/s:^:#:' \
		Rakefile || die

	# ordering problem, sent upstream
	epatch "${FILESDIR}"/${P}-order.patch
}
