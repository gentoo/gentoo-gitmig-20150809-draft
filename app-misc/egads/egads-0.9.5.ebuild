# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/egads/egads-0.9.5.ebuild,v 1.7 2008/02/08 02:04:27 robbat2 Exp $

DESCRIPTION="Entropy Gathering And Distribution System"
HOMEPAGE="http://www.securesoftware.com/download_${PN}.htm"
SRC_URI="http://www.securesoftware.com/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

egadsdatadir=/var/run/egads

src_unpack() {
	unpack "${A}"
	sed -i \
		-e '/^BINDIR/d' \
		-e '/^LIBDIR/d' \
		-e '/^INCLUDEDIR/d' \
		${S}/Makefile.in || die "Failed to fix Makefile.in"
}

src_compile() {
	econf \
		--with-egads-datadir="${egadsdatadir}" \
		--with-bindir=/usr/sbin \
		|| die
	emake LIBDIR="/usr/$(get_libdir)" || die
}

src_install() {
	keepdir ${egadsdatadir}
	fperms +t ${egadsdatadir}
	# NOT parallel safe, and no DESTDIR support
	emake -j1 install \
		BINDIR="${D}"/usr/sbin \
		LIBDIR="${D}"/usr/$(get_libdir) \
		INCLUDEDIR="${D}"/usr/include \
		|| die
	dodoc README* doc/*.txt
	dohtml doc/*.html
}
