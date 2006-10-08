# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdcollect/rrdcollect-0.2.3.ebuild,v 1.1 2006/10/08 19:04:43 jokey Exp $

DESCRIPTION="Read system statistical data and feed it to RRDtool"
HOMEPAGE="http://rrdcollect.sourceforget.net/"
SRC_URI="mirror://sourceforge/rrdcollect/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="pcre"

DEPEND="virtual/libpcap
	net-analyzer/rrdtool
	pcre? ( dev-libs/libpcre )"

RDEPEND=${DEPEND}

src_compile() {
	econf --disable-dependency-tracking \
		--with-libpcre \
		--with-librrd \
		$(use_with pcap libpcap) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}

