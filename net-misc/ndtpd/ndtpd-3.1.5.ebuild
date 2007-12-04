# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ndtpd/ndtpd-3.1.5.ebuild,v 1.13 2007/12/04 10:02:54 ulm Exp $

inherit eutils

IUSE=""

DESCRIPTION="A server for accessing CD-ROM books with NDTP(Network Directory Transfer Protocol)"
HOMEPAGE="http://www.sra.co.jp/people/m-kasahr/ndtpd/"
SRC_URI="ftp://ftp.sra.co.jp/pub/net/ndtp/ndtpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57"
RDEPEND=">=dev-libs/eb-3
	>=sys-libs/zlib-1.1.3-r2"

pkg_setup() {
	# this is required; src_install() needs ndtpuser:ndtpgrp
	enewgroup ndtpgrp 402
	enewuser ndtpuser 402 -1 /usr/share/dict ndtpgrp
}

src_unpack() {

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-eb4-gentoo.diff"
}

src_compile() {

	autoconf || die

	econf --with-eb-conf=/etc/eb.conf || die
	emake || die
}

src_install() {

	einstall || die

	newinitd "${FILESDIR}/ndtpd.initd" ndtpd

	insinto /etc
	newins ndtpd.conf{.sample,}

	keepdir /var/lib/ndtpd
	fowners ndtpuser:ndtpgrp /var/lib/ndtpd
	fperms 4710 /var/lib/ndtpd

	dodoc AUTHORS ChangeLog* INSTALL* NEWS README* UPGRADE*
}
