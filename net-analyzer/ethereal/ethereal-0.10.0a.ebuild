# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.10.0a.ebuild,v 1.1 2004/01/18 13:54:13 mholzer Exp $

IUSE="adns gtk ipv6 snmp ssl gtk2"
inherit libtool
S=${WORKDIR}/${P}
DESCRIPTION="A commercial-quality network protocol analyzer"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://www.ethereal.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64"

RDEPEND=">=sys-libs/zlib-1.1.4
	snmp? ( virtual/snmp )
	gtk? (
		gtk2? ( >=dev-libs/glib-2.0.4 =x11-libs/gtk+-2* )
		!gtk2? ( =x11-libs/gtk+-1.2* )
	)
	!gtk ( =dev-libs/glib-1.2* )
	ssl? ( >=dev-libs/openssl-0.9.6e )
	>=net-libs/libpcap-0.7.1
	>=dev-libs/libpcre-4.2
	adns? ( net-libs/adns )"

DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/bison
	sys-devel/flex"

src_unpack() {
	unpack ${A}
	cd ${S}
	# re-declaring functions is no good idea
	sed -i 's/getline/packet_giop_getline/g' packet-giop.c || sed failed
	elibtoolize
	# gcc related configure script braindamage
	sed -i "s|-I/usr/local/include||" configure || sed failed
	chmod +x ./configure
	sed -i "s|@PCAP_LIBS@ @SOCKET_LIBS@ @NSL_LIBS@|@PCAP_LIBS@ @SOCKET_LIBS@ @NSL_LIBS@ @ADNS_LIBS@|" \
		Makefile.am || sed failed
}

src_compile() {
	local myconf

	if [ -z "`use gtk`" ] && [ -z "`use gtk2`" ]; then
		myconf="${myconf} --disable-ethereal"
		# the asn1 plugin needs gtk
		sed -i -e '/plugins\/asn1/c\' Makefile.in || sed failed
		sed -i -e 's/\(^SUBDIRS.*\)asn1\(.*\)/\1\2/' \
			plugins/Makefile.in || sed failed
	fi

	use gtk2 && myconf="${myconf} --enable-gtk2"
	use ssl || myconf="${myconf} --without-ssl"
	use snmp || myconf="${myconf} --without-ucd-snmp --without-net-snmp"
	myconf="${myconf} $(use_enable ipv6)"
	myconf="${myconf} $(use_with adns)"

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
	make DESTDIR=${D} install
	dodoc AUTHORS COPYING ChangeLog INSTALL.* NEWS README* TODO
	insinto "/usr/share/pixmaps/"
	doins "image/hi48-app-ethereal.png"
}
