# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.9.14.ebuild,v 1.5 2004/03/24 21:01:48 mr_bones_ Exp $

inherit libtool

DESCRIPTION="A commercial-quality network protocol analyzer"
SRC_URI="http://www.ethereal.com/distribution/${P}.tar.bz2"
HOMEPAGE="http://www.ethereal.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc alpha"
IUSE="gtk ipv6 snmp ssl gtk2"

RDEPEND=">=sys-libs/zlib-1.1.4
	snmp? ( virtual/snmp )
	gtk? (
		gtk2? (
			>=dev-libs/glib-2.0.4
			=x11-libs/gtk+-2*
		)
		!gtk2? (
			=x11-libs/gtk+-1.2*
			=dev-libs/glib-1.2*
		)
	)
	ssl? ( >=dev-libs/openssl-0.9.6e )
	>=net-libs/libpcap-0.7.1"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-lang/perl
	sys-devel/bison
	sys-devel/flex"

src_unpack() {
	unpack ${A}
	cd ${S}
	elibtoolize
	# gcc related configure script braindamage
	sed -i \
		-e "s|-I/usr/local/include||" configure \
			|| die "sed configure failed"
	chmod +x ./configure
	sed -i \
		-e "s|@PCAP_LIBS@ @SOCKET_LIBS@ @NSL_LIBS@|@PCAP_LIBS@ @SOCKET_LIBS@ @NSL_LIBS@ @ADNS_LIBS@|" \
			Makefile.am \
				|| die "sed Makefile.am failed"
}

src_compile() {
	local myconf

	if [ -z "`use gtk`" ] && [ -z "`use gtk2`" ]; then
		myconf="${myconf} --disable-ethereal"
	fi

	use gtk2 && myconf="${myconf} --enable-gtk2"
	use ssl || myconf="${myconf} --without-ssl"
	use snmp || myconf="${myconf} --without-ucdsnmp"
	use ipv6 && myconf="${myconf} --enable-ipv6"

	econf \
		--enable-pcap \
		--enable-zlib \
		--enable-tethereal \
		--enable-editcap \
		--enable-mergecap \
		--enable-text2cap \
		--enable-idl2eth \
		--enable-dftest \
		--enable-randpkt \
		--sysconfdir=/etc/ethereal \
		--with-plugindir=/usr/lib/ethereal/plugins/${PV} \
		${myconf} || die "bad ./configure"
	addwrite "/usr/share/snmp/mibs/.index"
	emake || die "compile problem"
}

src_install() {
	addwrite "/usr/share/snmp/mibs/.index"
	dodir /usr/lib/ethereal/plugins/${PV}
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL.* NEWS README* TODO
}
