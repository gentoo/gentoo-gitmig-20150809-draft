# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/zoneminder/zoneminder-1.22.3.ebuild,v 1.4 2008/02/23 13:56:33 hollow Exp $

inherit eutils webapp autotools depend.php depend.apache

WEBAPP_MANUAL_SLOT="yes"

MY_PV=${PV/_/-}
MY_PN="ZoneMinder"

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
SRC_URI="http://www.zoneminder.com/downloads/${MY_PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mpeg"
SLOT="0"

DEPEND="app-admin/sudo
	>=media-libs/jpeg-6b
	>=dev-lang/perl-5.6.0
	dev-perl/Archive-Tar
	dev-perl/Archive-Zip
	dev-perl/DateManip
	dev-perl/DBD-mysql
	dev-perl/DBI
	dev-perl/Device-SerialPort
	dev-perl/libwww-perl
	dev-perl/MIME-Lite
	dev-perl/MIME-tools
	dev-perl/X10
	virtual/perl-Getopt-Long
	virtual/perl-libnet
	virtual/perl-Sys-Syslog
	virtual/perl-Time-HiRes"

RDEPEND="dev-perl/DBD-mysql
	mpeg? ( media-video/ffmpeg )
	media-libs/netpbm"

# we cannot use need_httpd_cgi here, since we need to setup permissions for the
# webserver in global scope (/etc/zm.conf etc), so we hardcode apache here.
need_apache
need_php_httpd

S="${WORKDIR}"/${MY_PN}-${MY_PV}

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use mysql
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/Makefile.am.patch
	epatch "${FILESDIR}"/zm_create.sql.in.diff
	epatch "${FILESDIR}"/ffmpeg.patch

	eautoreconf
}

src_compile() {
	econf --with-mysql=/usr \
		--with-webdir="${MY_HTDOCSDIR}" \
		--with-cgidir="${MY_CGIBINDIR}" \
		--with-webuser=apache \
		--with-webgroup=apache \
		$(use_with mpeg ffmpeg /usr) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	webapp_src_preinst

	keepdir /var/run/zm
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	fperms 0644 /etc/zm.conf

	keepdir /var/log/${PN}
	fowners apache:apache /var/log/${PN}
	fowners apache:apache /var/run/zm

	newinitd "${FILESDIR}"/init.d zoneminder
	newconfd "${FILESDIR}"/conf.d zoneminder

	dodoc AUTHORS ChangeLog INSTALL NEWS README README.[prt]* TODO
	dohtml README.html

	insinto /usr/share/${PN}/db
	doins db/zm_u* db/zm_create.sql

	for DIR in events images sound; do
		dodir "${MY_HTDOCSDIR}"/${DIR}
		webapp_serverowned "${MY_HTDOCSDIR}"/${DIR}
	done

	webapp_postinst_txt en "${FILESDIR}"/postinstall-2.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade.txt

	webapp_src_install
}
