# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/amap/amap-4.7.ebuild,v 1.1 2005/01/09 05:16:50 dragonheart Exp $

inherit eutils

DESCRIPTION="A network scanning tool for pentesters"
HOMEPAGE="http://www.thc.org/releases.php"
SRC_URI="http://packetstormsecurity.nl/groups/thc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( >=dev-libs/openssl-0.9.6j )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:/usr/local:/usr:' \
		-e '/AMAP_APPDEF_PATH/s:/bin:/share/amap:' \
		amap.h || die

	rm -rf pcre-3.9
	epatch ${FILESDIR}/${PV}-system-pcre.patch || die "patch failed"
}

src_compile() {
	# has it's own stupid custom configure script
	./configure || die "configure"
	sed -i \
		-e '/^XDEFINES=/s:=.*:=:' \
		-e '/^XLIBS=/s:=.*:=:' \
		-e '/^XLIBPATHS/s:=.*:=:' \
		-e '/^XIPATHS=/s:=.*:=:' \
		Makefile || die "pruning vars"
	if use ssl ; then
		sed -i \
			-e '/^XDEFINES=/s:=:=-DOPENSSL:' \
			-e '/^XLIBS=/s:=:=-lcrypto -lssl:' \
			Makefile || die "adding ssl"
	fi
	emake OPT="${CFLAGS}" || die "make"
}

src_install() {
	dobin amap amapcrap || die "dobin"
	insinto /usr/share/amap
	doins appdefs.* || die "doins"

	doman ${PN}.1
	dodoc README TODO CHANGES
}
