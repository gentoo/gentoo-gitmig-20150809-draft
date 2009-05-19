# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-shadow/ruby-shadow-1.4.1.ebuild,v 1.4 2009/05/19 15:28:23 fmccor Exp $

inherit ruby

DESCRIPTION="ruby shadow bindings"
HOMEPAGE="http://ttsky.net"
SRC_URI="http://ttsky.net/src/${P}.tar.gz"

S=${WORKDIR}/shadow-${PV}

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8"
