# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-zlib/ruby-zlib-0.6.0.ebuild,v 1.6 2004/06/25 02:04:02 agriffis Exp $

inherit ruby

IUSE=""

DESCRIPTION="Extension library to use zlib from Ruby"
HOMEPAGE="http://www.blue.sky.or.jp/atelier/ruby/"
SRC_URI="http://www.blue.sky.or.jp/atelier/ruby/${P}.tar.gz"

SLOT="0"
USE_RUBY="ruby16 ruby18"
LICENSE="Ruby"
KEYWORDS="x86 alpha ~ppc sparc"

DEPEND="sys-libs/zlib"
