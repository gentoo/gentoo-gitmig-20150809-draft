# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.45-r3.ebuild,v 1.1 2010/12/10 17:16:07 jer Exp $

EAPI="3"

inherit eutils autotools

DESCRIPTION="A grep for network layers"
HOMEPAGE="http://ngrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="ipv6 pcre"

DEPEND="net-libs/libpcap
	pcre? ( dev-libs/libpcre )"

src_prepare() {
	# Remove bundled libpcre to avoid occasional linking with them
	rm -rf pcre-5.0
	epatch "${FILESDIR}/${P}-build-fixes.patch"
	epatch "${FILESDIR}/${P}-setlocale.patch"
	epatch "${FILESDIR}/${P}-prefix.patch"
	eautoreconf
}

src_configure() {
	econf \
		--with-dropprivs-user=ngrep \
		--with-pcap-includes="${EPREFIX}"/usr/include/pcap \
		$(use_enable pcre) \
		$(use_enable ipv6)
}

pkg_preinst() {
	enewgroup ngrep
	enewuser ngrep -1 -1 -1 ngrep
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc doc/*.txt
}
