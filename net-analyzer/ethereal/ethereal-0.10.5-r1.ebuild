# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.10.5-r1.ebuild,v 1.5 2004/07/21 02:36:57 tgall Exp $

inherit libtool flag-o-matic gcc eutils

DESCRIPTION="A commercial-quality network protocol analyzer"
HOMEPAGE="http://www.ethereal.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ppc ~alpha ~amd64 ~ia64 ppc64"
IUSE="adns gtk ipv6 snmp ssl gtk2"

# if --disable-gtk2 is not passed to configure it will try to build with glib-2.0.
# --disable-ethereal do not have an influence.

# snmp support requires >=net-snmp-5.1.1. Taking virtual off: snmp? ( virtual/snmp )

RDEPEND=">=sys-libs/zlib-1.1.4
	snmp? ( >=net-analyzer/net-snmp-5.1.1 )
	>=dev-util/pkgconfig-0.15.0
	gtk? (  gtk2? ( >=dev-libs/glib-2.0.4 =x11-libs/gtk+-2* )
		!gtk2? ( =x11-libs/gtk+-1.2* ) )
	!gtk? ( =dev-libs/glib-1.2* )
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

	replace-flags -O3 -O
	replace-flags -O2 -O
	# Fix gcc-3.4 segfault #49238
	[ "`gcc-version`" == "3.4" ] && epatch ${FILESDIR}/0.10.4-gcc34.patch

	# running a full elibtoolize seems to break things in this
	# package... see bug 41831 (17 Feb 2004 agriffis)
	# elibtoolize --patch-only
}

src_compile() {
	local myconf="
		$(use_with ssl)
		$(use_enable ipv6)
		$(use_with adns)"

	if use gtk; then
		myconf="$(use_enable gtk2)"
	else
		myconf="--disable-gtk2"

		# --disable-ethereal do not have an influence
		#myconf="${myconf} --disable-ethereal"
		# the asn1 plugin needs gtk
		sed -i -e '/plugins.asn1/d' Makefile.in || die "sed failed"
		sed -i -e '/^SUBDIRS/s/asn1//' plugins/Makefile.in || die "sed failed"
	fi

	# if USE=snmp, then one of the snmp libraries will be available,
	# thanks to virtual/snmp.  In that case, let Ethereal use
	# whichever it finds.
	if ! use snmp; then
		myconf="${myconf} --without-ucd-snmp --without-net-snmp"
	fi

	econf \
		--enable-dftest \
		--enable-randpkt \
		--sysconfdir=/etc/ethereal \
		${myconf} || die "bad ./configure"

	addwrite "/usr/share/snmp/mibs/.index"
	emake || die "compile problem"
}

src_install() {
	addwrite "/usr/share/snmp/mibs/.index"
	dodir /usr/lib/ethereal/plugins/${PV}
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL.* NEWS README* TODO
	insinto "/usr/share/pixmaps/"
	doins "image/hi48-app-ethereal.png"
}
