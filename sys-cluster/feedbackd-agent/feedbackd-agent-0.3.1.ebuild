# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/feedbackd-agent/feedbackd-agent-0.3.1.ebuild,v 1.6 2004/09/04 17:17:03 axxo Exp $

inherit eutils flag-o-matic

DESCRIPTION="system for dynamic feedback of server loads in a Linux Virtual Server (LVS)-based cluster"
HOMEPAGE="http://www.redfishsoftware.com.au/projects/feedbackd/"
SRC_URI="mirror://sourceforge/feedbackd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	dev-libs/libxml2
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/compile-gnu-source.patch
	append-flags -O2
}

src_compile() {
	econf \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--with-xml-config=/usr/bin/xml2-config \
		--with-perl=/usr/bin/perl \
		|| die "bad ./configure"
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
