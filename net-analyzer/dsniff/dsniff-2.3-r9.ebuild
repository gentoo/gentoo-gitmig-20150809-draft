# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dsniff/dsniff-2.3-r9.ebuild,v 1.1 2006/04/17 01:08:27 jokey Exp $

inherit eutils flag-o-matic

DESCRIPTION="A collection of tools for network auditing and penetration testing"
HOMEPAGE="http://monkey.org/~dugsong/${PN}/"
SRC_URI="http://monkey.org/~dugsong/${PN}/${P}.tar.gz"
LICENSE="DSNIFF"
SLOT="0"
KEYWORDS="~alpha ~ppc ~x86"
IUSE=""

RDEPEND="net-libs/libpcap
	<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3
	=net-libs/libnids-1.18
	>=dev-libs/openssl-0.9.6e
	~sys-libs/db-3.2.9
	sys-apps/sed
	|| ( virtual/x11 x11-libs/libXmu )"

src_unpack() {
	unpack ${A}

	# Making sure data files get correctly installed and that dsniff
	# can find them
	# Working around dsniff b0rky config script
	# Data stuff goes into /etc/dsniff
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-libnet-1.0.patch
	sed -i \
		-e 's:-ldb:-ldb -lpthread:' \
		-e "s:lib':':" \
		configure || die "sed configure"
	sed -i 's:-DDSNIFF_LIBDIR=\\\"$(libdir)/\\\"::' Makefile.in || die "sed makefile"
	sed -i 's:/usr/local/lib:/etc/dsniff:' pathnames.h || die "sed pathnames"
	epatch "${FILESDIR}"/${PV}-makefile.patch

	# Allow amd64 compilation
	append-ldflags -lresolv

	# Fix for the local ip inversion (see bug #108144)
	sed -i "s/de->ip = htonl(lnet_ip);/de->ip = lnet_ip;/" dnsspoof.c \
		|| die "sed dnsspoof"

	# bug 125084
	epatch ${FILESDIR}/${PN}-httppostfix.patch
}

src_compile() {
	econf || die "econf failed"
	if has_version '>=sys-libs/glibc-2.4' ; then
		append-flags -DCLK_TCK=CLOCKS_PER_SEC
	fi
	emake || die "emake failed"
}

src_install() {
	make install install_prefix="${D}" || die
	dodir /etc/dsniff
	mv "${D}"/usr/{dnsspoof.hosts,dsniff.{magic,services}} "${D}"/etc/dsniff/
	dodoc CHANGES README TODO
}
