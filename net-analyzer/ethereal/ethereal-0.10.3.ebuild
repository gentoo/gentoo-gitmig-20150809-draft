# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.10.3.ebuild,v 1.2 2004/03/27 20:31:08 weeve Exp $

IUSE="adns gtk ipv6 snmp ssl gtk2"

inherit libtool

DESCRIPTION="A commercial-quality network protocol analyzer"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://www.ethereal.com/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 sparc ~ppc ~alpha ~amd64 ~ia64"

replace-flags '-O3' '-O'
replace-flags '-O2' '-O'

RDEPEND=">=sys-libs/zlib-1.1.4
	snmp? ( virtual/snmp )
	>=dev-util/pkgconfig-0.15.0
	gtk? (
		gtk2? ( >=dev-libs/glib-2.0.4 =x11-libs/gtk+-2* )
		!gtk2? ( =x11-libs/gtk+-1.2* )
	)
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
	unpack ${A} && cd ${S} || die

	# running a full elibtoolize seems to break things in this
	# package... see bug 41831 (17 Feb 2004 agriffis)
	elibtoolize --patch-only
}

src_compile() {
	local myconf="
		$(use_with ssl)
		$(use_enable ipv6)
		$(use_with adns)"

	if use gtk; then
		myconf="${myconf} $(use_enable gtk2)"
	else
		myconf="${myconf} --disable-ethereal"
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
	make DESTDIR=${D} install
	dodoc AUTHORS COPYING ChangeLog INSTALL.* NEWS README* TODO
	insinto "/usr/share/pixmaps/"
	doins "image/hi48-app-ethereal.png"
}
