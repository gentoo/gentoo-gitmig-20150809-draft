# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/amap/amap-4.5.ebuild,v 1.4 2004/07/31 21:51:51 tgall Exp $

DESCRIPTION="A network scanning tool for pentesters"
HOMEPAGE="http://www.thc.org/releases.php"
SRC_URI="http://packetstormsecurity.nl/groups/thc/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64 ~sparc ~ppc ppc64"
IUSE="ssl"
DEPEND="virtual/libc
	ssl? ( >=openssl-0.9.6j )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:/usr/local/bin:/usr/share/amap:g" amap.h || die
	sed -i -e "s:AMAP_PREFIX\":\"/usr:g" amap.h || die
}

src_compile() {
	./configure --prefix=/usr
	emake || die
}

src_install() {
	local files
	files="appdefs.trig appdefs.resp appdefs.rpc"

	# the makefile is difficult to patch in a gentoo-sane way
	# easyer to install by hand
	exeinto /usr/bin
	#files must be in exe directory (fix bug 39391)
	doexe amap amapcrap ${files}

	doman ${PN}.1

	dodoc README VOTE LICENSE TODO CHANGES
}
