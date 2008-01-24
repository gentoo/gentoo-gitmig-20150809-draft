# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tclink/tclink-3.4.4.ebuild,v 1.2 2008/01/24 04:55:11 mr_bones_ Exp $

inherit ruby

MY_P=${P}-ruby

DESCRIPTION="Make-like scripting in Ruby"
HOMEPAGE="http://www.trustcommerce.com/tclink.html"
SRC_URI="http://www.trustcommerce.com/downloads/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test"

S=${WORKDIR}/${MY_P}

RDEPEND="=dev-lang/ruby-1.8*
	>=dev-libs/openssl-0.9.8"
DEPEND=${RDEPEND}

src_compile() {
	./build.sh
	ruby tctest.rb
}
