# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-pcap/ruby-pcap-0.6.ebuild,v 1.3 2007/08/04 19:37:18 graaff Exp $

RUBY_BUG_145222=yes
inherit ruby

IUSE="examples"

DESCRIPTION="Extension library to use libpcap from Ruby"
HOMEPAGE="http://www.goto.info.waseda.ac.jp/%7efukusima/ruby/pcap-e.html"
SRC_URI="http://www.goto.info.waseda.ac.jp/%7efukusima/ruby/${P}.tar.gz"

SLOT="0"
USE_RUBY="ruby16 ruby18"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="net-libs/libpcap"
S="${WORKDIR}/pcap"

PATCHES="${FILESDIR}/ruby-pcap-0.6-fixnum.patch"
