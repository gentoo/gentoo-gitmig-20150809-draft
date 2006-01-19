# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dsniff/dsniff-2.4_beta1.ebuild,v 1.1 2006/01/19 18:03:21 vanquirius Exp $

inherit eutils flag-o-matic

DESCRIPTION="A collection of tools for network auditing and penetration testing"
HOMEPAGE="http://monkey.org/~dugsong/dsniff/"
SRC_URI="http://monkey.org/~dugsong/dsniff/beta/${P/_beta/b}.tar.gz
	mirror://gentoo/${PN}-2.4_beta1-debian.patch.bz2"
LICENSE="DSNIFF"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/libpcap
	>=net-libs/libnet-1.1.2.1-r1
	>=net-libs/libnids-1.18
	>=dev-libs/openssl-0.9.6e
	~sys-libs/db-3.2.9
	sys-apps/sed"

S="${WORKDIR}/${P/_beta1/}"

src_unpack() {
	unpack ${A}

	# Debian's patchset
	epatch "${DISTDIR}"/${PN}-2.4_beta1-debian.patch.bz2

	# Making sure data files get correctly installed and that dsniff
	# can find them
	# Working around dsniff b0rky config script
	# Data stuff goes into /etc/dsniff
	cd "${S}"
	sed -i \
		-e 's:-ldb:-ldb -lpthread:' \
		-e "s:lib':':" \
		configure || die "sed configure"
	sed -i 's:-DDSNIFF_LIBDIR=\\\"$(libdir)/\\\"::' Makefile.in || die "sed makefile"
	sed -i 's:/usr/local/lib:/etc/dsniff:' pathnames.h || die "sed pathnames"
	epatch "${FILESDIR}"/2.3-makefile.patch

	# Allow amd64 compilation
	append-ldflags -lresolv

	# Fix for the local ip inversion (see bug #108144)
	sed -i "s/de->ip = htonl(lnet_ip);/de->ip = lnet_ip;/" dnsspoof.c \
		|| die "sed dnsspoof"
}

src_install() {
	make install install_prefix="${D}" || die
	dodir /etc/dsniff
	mv "${D}"/usr/{dnsspoof.hosts,dsniff.{magic,services}} "${D}"/etc/dsniff/
	dodoc CHANGES README TODO
}
