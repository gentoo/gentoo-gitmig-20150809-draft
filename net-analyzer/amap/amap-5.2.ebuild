# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/amap/amap-5.2.ebuild,v 1.1 2006/01/16 01:28:57 vanquirius Exp $

inherit eutils

DESCRIPTION="A network scanning tool for pentesters"
HOMEPAGE="http://www.thc.org/thc-amap/"
SRC_URI="http://www.thc.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ssl"

DEPEND="virtual/libc
	dev-libs/libpcre
	ssl? ( >=dev-libs/openssl-0.9.6j )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	chmod 755 .
	sed -i -e "s:etc/:share/amap/:g" \
		amap-lib.c || die "sed amap-lib.c failed"
	sed -i 's:/usr/local:/usr:' amap.h || die "sed amap.h failed"
	sed -i '/DATADIR/s:/etc:/share/amap:' \
		Makefile.am || die "sed Makefile.am failed"
	rm -rf pcre-3.9

	epatch "${FILESDIR}"/4.8-system-pcre.patch
}

src_compile() {
	# has it's own stupid custom configure script
	./configure || die "configure failed"
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
	emake OPT="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin amap amapcrap || die "dobin failed"
	insinto /usr/share/amap
	doins appdefs.* || die "doins failed"

	doman ${PN}.1
	dodoc README TODO CHANGES
}
