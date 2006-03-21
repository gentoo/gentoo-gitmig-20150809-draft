# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf/iptraf-2.7.0-r2.ebuild,v 1.1 2006/03/21 23:01:42 jokey Exp $

inherit eutils flag-o-matic

V6PATCH_LEVEL=alpha12
DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
HOMEPAGE="http://iptraf.seul.org/"
SRC_URI="ftp://iptraf.seul.org/pub/iptraf/${P}.tar.gz
	http://dev.gentoo.org/~gmsoft/patches/${P}-ipv6-${V6PATCH_LEVEL}.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="ipv6 suid"

DEPEND=">=sys-libs/ncurses-5.2-r1"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-atheros.patch
	epatch ${DISTDIR}/${P}-ipv6-${V6PATCH_LEVEL}.diff

	# bug 89458
	if has_version '>=sys-kernel/linux-headers-2.6.11-r2' ; then
		epatch ${FILESDIR}/${P}-2.6.patch
	fi

	# bug 126479
	if has_version '>=sys-libs/glibc-2.4' ; then
		epatch ${FILESDIR}/${P}-ipv6-glibc24.patch
	fi

	cd src
	cp dirs.h dirs.h.orig
	sed -e s:/var/local/iptraf:/var/lib/iptraf: -e s:/usr/local/bin:/usr/sbin: dirs.h.orig > dirs.h
}

src_compile() {
	cd src

	if use ipv6 ; then
		append-flags -DUSE_IPV6
	fi

	if use suid ; then
		append-flags -DALLOWUSERS
	fi

	emake -j1 CFLAGS="$CFLAGS" DEBUG="" TARGET="/usr/sbin" WORKDIR="/var/lib/iptraf" \
	clean all || die "emake failed"
}

src_install() {
	dosbin src/{iptraf,cfconv,rvnamed} || die
	dodoc  FAQ README* CHANGES RELEASE-NOTES
	doman Documentation/*.8
	dohtml Documentation/*.html
	keepdir /var/{lib,run,log}/iptraf
}

pkg_postinst() {
	if use suid ; then
		einfo
		einfo "You've chosen to build iptraf with run-as-user support"
		einfo
		einfo "The app now has this support, but for security reasons"
		einfo "you need to run the following command to allow your users"
		einfo "to suid-run it:"
		einfo
		einfo " # chmod 4755 /usr/sbin/iptraf"
		einfo
	fi
}
