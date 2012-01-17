# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpflow/tcpflow-1.1.0_beta3.ebuild,v 1.1 2012/01/17 04:53:23 jer Exp $

EAPI="4"

MY_P="${P/_/-}"

DESCRIPTION="A tool for monitoring, capturing and storing TCP connections flows"
HOMEPAGE="http://afflib.org/"
SRC_URI="http://afflib.org/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
SLOT="0"
IUSE="test"

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
	test? ( sys-apps/coreutils )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e 's:`md5 -q \(.*\)`:`md5sum \1 | cut -f1 -d" "`:' tests/*.sh || die
}
