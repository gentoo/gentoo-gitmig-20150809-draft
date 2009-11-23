# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdcollect/rrdcollect-0.2.4.ebuild,v 1.1 2009/11/23 06:17:44 jer Exp $

DESCRIPTION="Read system statistical data and feed it to RRDtool"
HOMEPAGE="http://rrdcollect.sourceforge.net/"
SRC_URI="mirror://sourceforge/rrdcollect/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="pcre pcap exec"

DEPEND="pcap? ( virtual/libpcap )
	pcre? ( dev-libs/libpcre )"
RDEPEND="${DEPEND}
	net-analyzer/rrdtool"

src_compile() {
	econf --disable-dependency-tracking \
		--with-librrd \
		$(use_with pcre libpcre) \
		$(use_with pcap libpcap) \
		$(use_enable exec) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
