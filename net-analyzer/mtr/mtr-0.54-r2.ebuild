# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mtr/mtr-0.54-r2.ebuild,v 1.6 2004/09/05 21:06:10 gmsoft Exp $

IUSE="gtk ipv6"

DESCRIPTION="My TraceRoute. Excellent network diagnostic tool."
SRC_URI="ftp://ftp.bitwizard.nl/mtr/${P}.tar.gz ipv6? ( http://debian.fabbione.net/debian-ipv6/dists/sid/ipv6/pool/mtr_${PV}-1.0.ipv6.r1.diff.gz )"
HOMEPAGE="http://www.bitwizard.nl/mtr/"

DEPEND=">=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc hppa alpha"

src_unpack() {

	unpack ${P}.tar.gz
	cd ${S}
	use ipv6 && zcat ${DISTDIR}/mtr_0.54-1.0.ipv6.r1.diff.gz | patch -p 1

}

src_compile() {
	local myconf
	use gtk || myconf="${myconf} --without-gtk"

	econf ${myconf} || die
	emake || die
}

src_install() {
	# this binary is universal. ie: it does both console and gtk.
	make DESTDIR=${D} sbindir=/usr/bin install || die

	fowners root:wheel /usr/bin/mtr
	fperms 4710 /usr/bin/mtr

	dodoc AUTHORS COPYING ChangeLog FORMATS NEWS README SECURITY TODO
}
