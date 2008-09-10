# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.45-r1.ebuild,v 1.10 2008/09/10 10:42:44 pva Exp $

inherit eutils autotools

DESCRIPTION="A grep for network layers"
HOMEPAGE="http://ngrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="ipv6 pcre"

DEPEND="virtual/libc
	net-libs/libpcap
	pcre? ( dev-libs/libpcre )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}.patch
	epatch "${FILESDIR}"/${P}-Makefile.in.patch
	eautoreconf
}

src_compile() {
	econf --with-dropprivs-user=ngrep \
		$(use_enable pcre) \
		$(use_enable ipv6) || die "econf failed"
	emake || die "emake failed"
}

pkg_preinst() {
	enewgroup ngrep
	enewuser ngrep -1 -1 -1 ngrep
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc doc/*.txt
}
