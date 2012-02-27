# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpflow/tcpflow-1.1.1.ebuild,v 1.1 2012/02/27 11:18:59 radhermit Exp $

EAPI="4"

DESCRIPTION="A tool for monitoring, capturing and storing TCP connections flows"
HOMEPAGE="http://afflib.org/"
SRC_URI="http://afflib.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
SLOT="0"
IUSE="test"

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
	test? ( sys-apps/coreutils )"

src_prepare() {
	sed -i -e 's:`md5 -q \(.*\)`:`md5sum \1 | cut -f1 -d" "`:' tests/*.sh || die
}
