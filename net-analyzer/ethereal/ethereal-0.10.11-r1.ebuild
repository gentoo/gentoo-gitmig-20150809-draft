# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.10.11-r1.ebuild,v 1.1 2005/07/19 12:22:08 kaiowas Exp $

inherit libtool flag-o-matic eutils

DESCRIPTION="A commercial-quality network protocol analyzer"
HOMEPAGE="http://www.ethereal.com/"
SRC_URI="http://www.ethereal.com/distribution/${P}.tar.bz2"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64 ~ia64 ~ppc64"
IUSE="adns gtk ipv6 snmp ssl gtk2 kerberos"

# if --disable-gtk2 is not passed to configure it will try to build with glib-2.0.
# --disable-ethereal do not have an influence.


RDEPEND=">=sys-libs/zlib-1.1.4
	snmp? ( >=net-analyzer/net-snmp-5.1.1 )
	>=dev-util/pkgconfig-0.15.0
	gtk? (  gtk2? ( >=dev-libs/glib-2.0.4 =x11-libs/gtk+-2* )
		!gtk2? ( =x11-libs/gtk+-1.2* )
		x11-libs/pango
		dev-libs/atk )
	!gtk? ( =dev-libs/glib-1.2* )
	ssl? ( >=dev-libs/openssl-0.9.6e )
	virtual/libpcap
	>=dev-libs/libpcre-4.2
	adns? ( net-libs/adns )
	kerberos? ( virtual/krb5 )"

DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/bison
	sys-devel/flex
	sys-apps/sed"

src_unpack() {
	unpack ${P}.tar.bz2

	# this makes life easy
	EPATCH_OPTS="-d ${S}"

	EPATCH_SINGLE_MSG="Adding patch to allow use of fifo files as input" \
	epatch ${FILESDIR}/fifo.patch
}

src_compile() {

	replace-flags -O? -O

	# Fix gcc-3.4 segfault #49238
	#[ "`gcc-version`" == "3.4" ] && append-flags -fno-unroll-loops

	local myconf

	if use gtk; then
		myconf="${myconf} $(use_enable gtk2)"
	else
		myconf="${myconf} --disable-gtk2"

		# the asn1 plugin needs gtk
		sed -i -e '/plugins.asn1/d' Makefile.in || die "sed failed"
		sed -i -e '/^SUBDIRS/s/asn1//' plugins/Makefile.in || die "sed failed"
	fi

	econf \
		$(use_with ssl) \
		$(use_enable ipv6) \
		$(use_with adns) \
		$(use_with kerberos krb5) \
		$(use_with snmp net-snmp) \
		--without-ucd-snmp \
		--enable-dftest \
		--enable-randpkt \
		--sysconfdir=/etc/ethereal \
		--enable-editcap \
		--enable-capinfos \
		--enable-text2pcap \
		--enable-dftest \
		--enable-randpkt \
		${myconf} || die "bad ./configure"

	# fixes an access violation caused by libnetsnmp - see bug 79068
	use snmp && export MIBDIRS="${D}/usr/share/snmp/mibs"

	emake || die "compile problem"
}

src_install() {
	dodir /usr/lib/ethereal/plugins/${PV}
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL.* NEWS README*

	insinto /usr/share/icons/hicolor/16x16/apps
	newins ${S}/image/hi16-app-ethereal.png ethereal.png
	insinto /usr/share/icons/hicolor/32x32/apps
	newins ${S}/image/hi32-app-ethereal.png ethereal.png
	insinto /usr/share/icons/hicolor/48x48/apps
	newins ${S}/image/hi48-app-ethereal.png ethereal.png
	make_desktop_entry ethereal "Ethereal" ethereal
}

pkg_postinst() {
	ewarn "Due to a history of security flaws in this piece of software, it may contain more flaws."
	ewarn "To protect yourself against malicious damage due to potential flaws in this product we recommend"
	ewarn "you take the following security precautions when running ethereal in an untrusted environment:"
	ewarn "do no run any longer than you need to;"
	ewarn "use in a root jail - prefereably one that has been hardened with grsec like rootjail protections;"
	ewarn "use a hardened operating system;"
	ewarn "do not listen to addition interfaces;"
	ewarn "if possible, run behind a firewall;"
	ewarn "take a capture with tcpdump and analyze the contents offline running ethereal as a the least priviledged user; and"
	ewarn "subscribe to ethereal's announce list to be notified of newly discovered vulnerabilities."
}
