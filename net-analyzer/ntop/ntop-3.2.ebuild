# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntop/ntop-3.2.ebuild,v 1.1 2005/12/30 03:56:48 vapier Exp $

inherit eutils autotools

DESCRIPTION="tool that shows network usage like top"
HOMEPAGE="http://www.ntop.org/ntop.html"
SRC_URI="mirror://sourceforge/ntop/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="ipv6 nls snmp ssl tcpd zlib"

DEPEND="sys-apps/gawk
	>=sys-devel/libtool-1.4
	>=sys-libs/gdbm-1.8.0
	virtual/libpcap
	>=media-libs/gd-2.0.22
	>=media-libs/libpng-1.2.5
	snmp? ( net-analyzer/net-snmp )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r4 )
	zlib? ( sys-libs/zlib )"

# Needed by xmldumpPlugin - couldn't get it to work
#	dev-libs/gdome2
#	>=dev-libs/glib-2"

pkg_setup() {
	enewgroup ntop
	enewuser ntop -1 -1 /var/lib/ntop ntop
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/globals-core.c.diff
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_compile() {
	# force disable xmldumpPlugin
	export \
		ac_cv_header_glib_h=no \
		ac_cv_header_glibconfig_h=no \
		ac_cv_header_gdome_h=no \
		ac_cv_lib_glib_g_date_julian=no \
		ac_cv_lib_xml2_xmlCheckVersion=no \
		ac_cv_lib_gdome_gdome_di_saveDocToFile=no

	econf \
		$(use_enable ipv6) \
		$(use_enable nls i18n) \
		$(use_enable snmp) \
		$(use_with ssl) $(use_enable ssl sslv3) $(use_enable sslwatchdog) \
		$(use_with tcpd) \
		$(use_with zlib) \
		|| die "configure problem"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR="${D}" install || die "install problem"

	chown -R ntop:ntop "${D}"/usr/share/ntop
	keepdir /var/lib/ntop
	fowners ntop:ntop /var/lib/ntop
	fperms 750 /var/lib/ntop

	dodoc AUTHORS CONTENTS ChangeLog MANIFESTO NEWS
	dodoc PORTING README SUPPORT_NTOP.txt THANKS $(find docs -type f)

	newinitd "${FILESDIR}"/ntop-init ntop
	newconfd "${FILESDIR}"/ntop-confd ntop
}
