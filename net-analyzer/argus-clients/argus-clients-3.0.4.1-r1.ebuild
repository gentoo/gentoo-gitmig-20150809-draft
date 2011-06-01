# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/argus-clients/argus-clients-3.0.4.1-r1.ebuild,v 1.2 2011/06/01 00:50:30 jer Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Clients for net-analyzer/argus"
HOMEPAGE="http://www.qosient.com/argus/"
SRC_URI="http://qosient.com/argus/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug geoip mysql tcpd"

#sasl? ( >=dev-libs/cyrus-sasl-1.5.24 )
MY_CDEPEND="
	net-libs/libpcap
	net-analyzer/rrdtool[perl]
	geoip? ( dev-libs/geoip )
	mysql? ( virtual/mysql )
	sys-libs/ncurses
"

#	>=net-analyzer/argus-2.0.6[sasl?]"
RDEPEND="
	${MY_CDEPEND}
	>=net-analyzer/argus-3.0.2
"

DEPEND="
	${MY_CDEPEND}
	>=sys-devel/bison-1.28
	>=sys-devel/flex-2.4.6
"

src_prepare() {
	for x in $(find . -name "Makefile.in"); do
		sed -i "s:\$(CFLAGS):& \$(LDFLAGS) :" $x
	done
	epatch "${FILESDIR}"/${P}-disable-tcp-wrappers-automagic.patch
	eautoreconf
}

src_configure() {
	use debug && touch .debug
	#	$(use_with sasl) \
	econf \
		$(use_with geoip GeoIP /usr/) \
		$(use_with tcpd wrappers) \
		$(use_with mysql)
}

src_compile() {
	emake  CCOPT="${CFLAGS} ${LDFLAGS}" || die "emake failed"
}

src_install() {
	# argus_parse.a and argus_common.a are supplied by net-analyzer/argus
	dobin bin/ra* radium/radium || die "Failed to install ra*"
	dodoc ChangeLog CREDITS README doc/{CHANGES,FAQ,HOW-TO} || die
	doman man/man{1,5}/*
}
