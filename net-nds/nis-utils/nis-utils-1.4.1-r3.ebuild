# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/nis-utils/nis-utils-1.4.1-r3.ebuild,v 1.1 2008/01/16 02:38:43 antarus Exp $

inherit eutils versionator

DESCRIPTION="NIS+ utilities"
HOMEPAGE="http://www.linux-nis.org/"
SRC_URI="mirror://kernel/linux/utils/net/NIS+/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

DEPEND="dev-libs/gmp"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-gmp-fixes.patch"

	# nisping.c calls internal glibc functions, patch it if glibc is > 2.5
	has_version '>=sys-apps/glibc-2.6' && \
		epatch "${FILESDIR}/${PN}-glibc-internal-fix.patch"
}

src_compile() {
	econf $(use_enable nls) || die "Configure failed"
	emake || die "Make Failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install Failed"
	mv "${D}"/usr/etc "${D}"/
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
	newinitd "${FILESDIR}"/keyserv.rc keyserv
}
