# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.10.9-r1.ebuild,v 1.2 2005/01/25 10:39:17 ka0ttic Exp $

inherit libtool flag-o-matic eutils

DESCRIPTION="A commercial-quality network protocol analyzer"
HOMEPAGE="http://www.ethereal.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64 ~ia64 ~ppc64"
IUSE="adns gtk ipv6 snmp ssl gtk2 kerberos"

# if --disable-gtk2 is not passed to configure it will try to build with glib-2.0.
# --disable-ethereal do not have an influence.

# snmp support requires >=net-snmp-5.1.1. Taking virtual off: snmp? ( virtual/snmp )


RDEPEND=">=sys-libs/zlib-1.1.4
	snmp? ( >=net-analyzer/net-snmp-5.1.1 )
	>=dev-util/pkgconfig-0.15.0
	gtk? (  gtk2? ( >=dev-libs/glib-2.0.4 =x11-libs/gtk+-2* )
		!gtk2? ( =x11-libs/gtk+-1.2* )
		x11-libs/pango
		dev-libs/atk )
	!gtk? ( =dev-libs/glib-1.2* )
	ssl? ( >=dev-libs/openssl-0.9.6e )
	>=net-libs/libpcap-0.7.1
	>=dev-libs/libpcre-4.2
	adns? ( net-libs/adns )
	kerberos? ( virtual/krb5 )"

DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/bison
	sys-devel/flex"

src_compile() {

	replace-flags -O3 -O
	replace-flags -O2 -O

	# Fix gcc-3.4 segfault #49238
	#[ "`gcc-version`" == "3.4" ] && append-flags -fno-unroll-loops

	local myconf="
		$(use_with ssl)
		$(use_enable ipv6)
		$(use_with adns)
		$(use_with kerberos krb5)
		$(use_with snmp net-snmp)"

	if use gtk; then
		myconf="${myconf} $(use_enable gtk2)"
	else
		myconf="${myconf} --disable-gtk2"

		# the asn1 plugin needs gtk
		sed -i -e '/plugins.asn1/d' Makefile.in || die "sed failed"
		sed -i -e '/^SUBDIRS/s/asn1//' plugins/Makefile.in || die "sed failed"
	fi

	econf \
		--without-ucd-snmp \
		--enable-dftest \
		--enable-randpkt \
		--sysconfdir=/etc/ethereal \
		${myconf} || die "bad ./configure"

	# fixes an access violation caused by libnetsnmp - see bug 79068
	use snmp && export MIBDIRS="${D}/usr/share/snmp/mibs"

	emake || die "compile problem"
}

src_install() {
	dodir /usr/lib/ethereal/plugins/${PV}
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL.* NEWS README* TODO
	insinto "/usr/share/pixmaps/"
	doins "image/hi48-app-ethereal.png"
}
