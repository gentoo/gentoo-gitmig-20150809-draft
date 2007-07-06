# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/wireshark/wireshark-0.99.6.ebuild,v 1.1 2007/07/06 16:09:31 jokey Exp $

inherit libtool flag-o-matic eutils toolchain-funcs

DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="http://www.wireshark.org/"
SRC_URI="mirror://sourceforge/wireshark/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="adns gtk ipv6 portaudio snmp ssl kerberos threads selinux"

RDEPEND="sys-libs/zlib
	snmp? ( net-analyzer/net-snmp )
	gtk? ( >=dev-libs/glib-2.0.4
		=x11-libs/gtk+-2*
		x11-libs/pango
		dev-libs/atk )
	!gtk? ( =dev-libs/glib-1.2* )
	ssl? ( dev-libs/openssl )
	!ssl? (	net-libs/gnutls )
	net-libs/libpcap
	dev-libs/libpcre
	adns? ( net-libs/adns )
	kerberos? ( virtual/krb5 )
	portaudio? ( media-libs/portaudio )
	selinux? ( sec-policy/selinux-wireshark )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15.0
	dev-lang/perl
	sys-devel/bison
	sys-devel/flex
	sys-apps/sed"

pkg_setup() {
	# bug 119208
	if has_version "<=dev-lang/perl-5.8.8_rc1" && built_with_use dev-lang/perl minimal ; then
		ewarn "wireshark will not build if dev-lang/perl is compiled with"
		ewarn "USE=minimal. Rebuild dev-lang/perl with USE=-minimal and try again."
		ebeep 5
		die "dev-lang/perl compiled with USE=minimal"
	fi

	if ! use gtk; then
		ewarn "USE=-gtk will mean no gui called wireshark will be created and"
		ewarn "only command line utils are available"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"/epan
	epatch "${FILESDIR}"/wireshark-except-double-free.diff
	epatch "${FILESDIR}"/wireshark-epan_dissectors_packet-diameter.diff
}

src_compile() {
	# optimization bug, see bug #165340
	if [[ "$(gcc-version)" == "3.4" ]] ; then
		elog "Found gcc 3.4, forcing -O3 into CFLAGS"
		replace-flags -O? -O3
	else
		elog "Forcing -O into CFLAGS"
		replace-flags -O? -O
	fi

	# see bug #133092
	filter-flags -fstack-protector

	local myconf

	if use gtk; then
		einfo "Building with gtk support"
	else
		einfo "Building without gtk support"
		myconf="${myconf} --disable-wireshark"
		# the asn1 plugin needs gtk
		sed -i -e '/plugins.asn1/d' Makefile.in || die "sed failed"
		sed -i -e '/^SUBDIRS/s/asn1//' plugins/Makefile.in || die "sed failed"
	fi

	#	$(use_with lua) \
	econf $(use_with ssl) \
		$(use_enable ipv6) \
		$(use_with adns) \
		$(use_with kerberos krb5) \
		$(use_with snmp net-snmp) \
		$(use_with portaudio) \
		$(use_enable gtk gtk2) \
		$(use_enable threads) \
		--without-ucd-snmp \
		--enable-dftest \
		--enable-randpkt \
		--sysconfdir=/etc/wireshark \
		--enable-editcap \
		--enable-capinfos \
		--enable-text2pcap \
		--enable-dftest \
		--enable-randpkt \
		${myconf} || die "econf failed"

	# fixes an access violation caused by libnetsnmp - see bug 79068
	use snmp && export MIBDIRS="${D}/usr/share/snmp/mibs"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /usr/include/wiretap
	doins wiretap/wtap.h

	dodoc AUTHORS ChangeLog NEWS README*

	insinto /usr/share/icons/hicolor/16x16/apps
	newins "${S}"/image/hi16-app-wireshark.png wireshark.png
	insinto /usr/share/icons/hicolor/32x32/apps
	newins "${S}"/image/hi32-app-wireshark.png wireshark.png
	insinto /usr/share/icons/hicolor/48x48/apps
	newins "${S}"/image/hi48-app-wireshark.png wireshark.png
	make_desktop_entry wireshark "Wireshark" wireshark
	dosym tshark /usr/bin/tethereal
	use gtk && dosym wireshark /usr/bin/ethereal
}

pkg_postinst() {
	ewarn "Due to a history of security flaws in this piece of software, it may contain more flaws."
	ewarn "To protect yourself against malicious damage due to potential flaws in this product we recommend"
	ewarn "you take the following security precautions when running wireshark in an untrusted environment:"
	ewarn "do not run any longer than you need to;"
	ewarn "use in a root jail - prefereably one that has been hardened with grsec like rootjail protections;"
	ewarn "use a hardened operating system;"
	ewarn "do not listen to addition interfaces;"
	ewarn "if possible, run behind a firewall;"
	ewarn "take a capture with tcpdump and analyze running wireshark as a least privileged user;"
	ewarn "and subscribe to wireshark's announce list to be notified of newly discovered vulnerabilities."
}
