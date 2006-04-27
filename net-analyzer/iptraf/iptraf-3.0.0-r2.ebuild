# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf/iptraf-3.0.0-r2.ebuild,v 1.3 2006/04/27 04:40:05 weeve Exp $

inherit eutils flag-o-matic

DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
HOMEPAGE="http://iptraf.seul.org/"
SRC_URI="ftp://iptraf.seul.org/pub/iptraf/${P}.tar.gz
	mirror://gentoo/${P}-ipv6.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="ipv6 suid"

DEPEND=">=sys-libs/ncurses-5.2-r1"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-atheros.patch
	epatch ${FILESDIR}/${P}-build.patch
	epatch ${FILESDIR}/${P}-linux-headers.patch
	epatch ${FILESDIR}/${P}-bnep.patch
	epatch ${FILESDIR}/${P}-Makefile.patch

	# bug 128965
	epatch ${FILESDIR}/${P}-headerfix.patch

	sed -i \
		-e 's:/var/local/iptraf:/var/lib/iptraf:g' \
		-e "s:Documentation/:/usr/share/doc/${PF}:g" \
		Documentation/*.* || die "sed doc paths"

	if use ipv6 ; then
		epatch ${DISTDIR}/${P}-ipv6.patch.bz2

		# bug 126479
		if has_version '>=sys-libs/glibc-2.4' ; then
			epatch ${FILESDIR}/${P}-ipv6-glibc24.patch
		fi

		# bug 128965
		epatch ${FILESDIR}/${P}-ipv6-headerfix.patch
	fi
}

src_compile() {
	if use suid ; then
		append-flags -DALLOWUSERS
	fi
	emake CFLAGS="$CFLAGS" -C src || die "emake failed"
}

src_install() {
	dosbin src/{iptraf,rawtime,rvnamed} || die
	dodoc FAQ README* CHANGES RELEASE-NOTES
	doman Documentation/*.8
	dohtml -r Documentation/*
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
