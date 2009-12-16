# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-spec/test-spec-0.10.0-r1.ebuild,v 1.1 2009/12/16 15:23:15 a3li Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"
inherit ruby-fakegem

DESCRIPTION="A library to do Behavior Driven Development with Test::Unit"
HOMEPAGE="http://chneukirchen.org/blog/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

all_ruby_install() {
	ruby_fakegem_binwrapper specrb
	dodoc README SPECS || die

	if use doc; then
		dodoc examples/* || die
	fi
}
