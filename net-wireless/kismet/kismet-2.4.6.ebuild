# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/kismet-2.4.6.ebuild,v 1.5 2003/02/11 19:39:18 latexer Exp $

IUSE="X snmp ssl"


S="${WORKDIR}/${P}"
DESCRIPTION="Kismet is a 802.11b wireless network sniffer."
SRC_URI="http://www.kismetwireless.net/code/${P}.tar.gz
	 http://www.ethereal.com/distribution/old-versions/ethereal-0.9.5.tar.gz"
HOMEPAGE="http://www.kismetwireless.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc  ~ppc"

DEPEND=">=dev-libs/expat-1.95.4
		>=sys-libs/ncurses-5.2
		>=net-libs/libpcap-0.7.1
		snmp? ( >=net-analyzer/ucd-snmp-4.2.5 )
		X? ( virtual/x11 =x11-libs/gtk+-1.2* >=dev-libs/glib-2.0 )
		ssl? ( >=dev-libs/openssl-0.9.6b )"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/ethereal-0.9.5
	#This is a new hack for gcc-3.1 compatibility
		einfo "Hax0ring ethereal's configure"
		sed -e "1961,1962d;3358,3359d;3382,3383d" configure \
			>configure.hacked
	mv configure.hacked configure
	chmod +x configure
}
src_compile() {
	cd ${WORKDIR}/ethereal-0.9.5
	einfo "Need to first configure and compile ethereal"
	# need to compile ethereal as it is installed
	local myconf
	use X || myconf="${myconf} --disable-ethereal"
	use ssl || myconf="${myconf} --without-ssl"
	use snmp || myconf="${myconf} --without-ucdsnmp"

	./configure \
		--prefix=/usr --enable-pcap \
    	--enable-zlib --enable-ipv6 \
    	--enable-tethereal --enable-editcap \
  		--enable-mergecap --enable-text2cap \
    	--enable-idl2eth --enable-dftest \
    	--enable-randpkt --mandir=/usr/share/man \
    	--sysconfdir=/etc/ethereal \
    	--with-plugindir=/usr/lib/ethereal/plugins/${PV} \
    	--host=${CHOST} ${myconf} || die "bad ./configure for ethereal source"
	emake || die "compile problem for ethereal source"

	cd ${S} # return to kismet compile
	einfo "Returning to kismet compile"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-ethereal=${WORKDIR}/ethereal-0.9.5 \
		--mandir=/usr/share/man || die "./configure failed"
	make dep || die "make dep for kismet barfed"
	emake || die "compile of kismet failed"
}

src_install () {
	dodir /etc
	dodir /usr/bin
	make prefix=${D}/usr \
		ETC=${D}/etc MAN=${D}/usr/share/man \
		SHARE=${D}/usr/share/${PN} install
	dodoc CHANGELOG FAQ README
}
