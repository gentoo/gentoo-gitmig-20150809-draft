# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dd-rhelp/dd-rhelp-0.0.6.ebuild,v 1.3 2007/04/11 07:45:23 opfer Exp $

MY_P="${P/-/_}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Wrapper for dd_rescue that can recover damaged files/partitions from block devices"
HOMEPAGE="http://www.kalysto.org/utilities/dd_rhelp/index.en.html"
SRC_URI="http://www.kalysto.org/pkg/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~mips ~x86"
IUSE=""

DEPEND="sys-fs/dd-rescue"
RDEPEND="${DEPEND}
	sys-devel/bc"

src_install() {
	make install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO doc/example.txt
}
