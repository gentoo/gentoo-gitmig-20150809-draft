# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-bz2/ruby-bz2-0.2.2.ebuild,v 1.2 2006/06/18 19:38:57 ticho Exp $

inherit ruby

MY_P="${P/ruby-}"
DESCRIPTION="Ruby interface to libbz2"
HOMEPAGE="http://moulon.inra.fr/ruby/bz2.html"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""
USE_RUBY="ruby18 ruby19"

S="${WORKDIR}/${MY_P}"

DEPEND="app-arch/bzip2"

src_install() {
	ruby_src_install
	dodoc Changes
	dohtml bz2.html
}
