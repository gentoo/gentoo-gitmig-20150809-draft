# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ndtpd/ndtpd-3.1.5.ebuild,v 1.14 2008/06/21 15:04:05 dirtyepic Exp $

inherit autotools eutils

IUSE=""

DESCRIPTION="A server for accessing CD-ROM books with NDTP(Network Directory Transfer Protocol)"
HOMEPAGE="http://www.sra.co.jp/people/m-kasahr/ndtpd/"
SRC_URI="ftp://ftp.sra.co.jp/pub/net/ndtp/ndtpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND="${RDEPEND}"
RDEPEND=">=dev-libs/eb-3"

pkg_setup() {
	# this is required; src_install() needs ndtpuser:ndtpgrp
	enewgroup ndtpgrp 402
	enewuser ndtpuser 402 -1 /usr/share/dict ndtpgrp
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-eb4-gentoo.diff"
	epatch "${FILESDIR}"/${P}-canonicalize.patch
	eautoreconf
}

src_compile() {
	econf --with-eb-conf=/etc/eb.conf || die "Failed during configure."
	emake || die "Failed during make."
}

src_install() {

	emake DESTDIR="${D}" install || die "Failed during install."

	newinitd "${FILESDIR}/ndtpd.initd" ndtpd

	insinto /etc
	newins ndtpd.conf{.sample,}

	keepdir /var/lib/ndtpd
	fowners ndtpuser:ndtpgrp /var/lib/ndtpd
	fperms 4710 /var/lib/ndtpd

	dodoc AUTHORS ChangeLog* INSTALL* NEWS README* UPGRADE*
}
