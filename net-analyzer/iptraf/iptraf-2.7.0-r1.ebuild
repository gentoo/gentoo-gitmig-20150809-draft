# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf/iptraf-2.7.0-r1.ebuild,v 1.23 2005/11/01 05:10:29 vapier Exp $

inherit eutils flag-o-matic

V6PATCH_LEVEL=alpha12
DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
HOMEPAGE="http://iptraf.seul.org/"
SRC_URI="ftp://iptraf.seul.org/pub/iptraf/${P}.tar.gz
	http://dev.gentoo.org/~gmsoft/patches/${P}-ipv6-${V6PATCH_LEVEL}.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa mips ppc ppc64 sparc x86"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5.2-r1"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-atheros.patch
	epatch "${DISTDIR}"/${P}-ipv6-${V6PATCH_LEVEL}.diff
#    use ipv6 && epatch ${DISTDIR}/${P}-ipv6-${V6PATCH_LEVEL}.diff

	# bug 89458
	has_version '>=sys-kernel/linux-headers-2.6.11-r2' && \
		epatch "${FILESDIR}"/${P}-2.6.patch

	cd src
	cp dirs.h dirs.h.orig
	sed -e s:/var/local/iptraf:/var/lib/iptraf: -e s:/usr/local/bin:/usr/sbin: dirs.h.orig > dirs.h
}

src_compile() {
	cd src
	use ipv6 && append-flags -DUSE_IPV6
	emake -j1 CFLAGS="$CFLAGS" DEBUG="" TARGET="/usr/sbin" WORKDIR="/var/lib/iptraf" \
	clean all || die "emake failed"
}

src_install() {
	dosbin src/{iptraf,cfconv,rvnamed} || die
	dodoc  FAQ README* CHANGES RELEASE-NOTES INSTALL
	doman Documentation/*.8
	dohtml Documentation/*.html
	keepdir /var/{lib,run,log}/iptraf
}
