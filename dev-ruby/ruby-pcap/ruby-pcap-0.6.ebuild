# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-pcap/ruby-pcap-0.6.ebuild,v 1.1 2006/12/17 02:04:06 pclouds Exp $

inherit ruby

IUSE=""

DESCRIPTION="Extension library to use libpcap from Ruby"
HOMEPAGE="http://www.goto.info.waseda.ac.jp/%7efukusima/ruby/pcap-e.html"
SRC_URI="http://www.goto.info.waseda.ac.jp/%7efukusima/ruby/${P}.tar.gz"

SLOT="0"
USE_RUBY="ruby16 ruby18"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="net-libs/libpcap"
S="${WORKDIR}/pcap"
