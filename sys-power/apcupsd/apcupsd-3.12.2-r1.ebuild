# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/apcupsd/apcupsd-3.12.2-r1.ebuild,v 1.3 2006/10/22 19:49:01 tantive Exp $

inherit eutils depend.apache

DESCRIPTION="APC UPS daemon with integrated tcp/ip remote shutdown"
HOMEPAGE="http://www.apcupsd.org/"
SRC_URI="mirror://sourceforge/apcupsd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="doc snmp usb apache2 cgi threads ncurses nls lighttpd"

DEPEND="snmp? ( net-analyzer/net-snmp )
	cgi? ( >=media-libs/gd-1.8.4
		apache2? ( >=net-www/apache-2.0.54-r30 )
		lighttpd? ( www-servers/lighttpd )
		)
	ncurses? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}
	virtual/mta"

XPIDDIR=/var/run
XLOGDIR=/var/log
XLOCKDIR=/var/lock
XSYSCONFDIR=/etc/apcupsd
XPWRFAILDIR=${XSYSCONFDIR}

src_unpack() {
	unpack ${A}
	cd ${S}/platforms/gentoo
	epatch ${FILESDIR}/${PV}/apcupsd.in.patch

	cd ${S}/platforms
	epatch ${FILESDIR}/${PV}/etc.patch

	# Avoid usage of install -s, leave to portage stripping binaries
	sed -i -e 's:(INSTALL_PROGRAM) -s:(INSTALL_PROGRAM):g' \
		${S}/src/Makefile.in ${S}/src/cgi/Makefile.in
}

src_compile() {
	local myconf
	use cgi && myconf="${myconf} --enable-cgi --with-css-dir=/var/www/apcupsd --with-cgi-bin=/var/www/apcupsd"
	use usb && myconf="${myconf} --with-upstype=usb --with-upscable=usb --enable-usb"
	use !usb && myconf="${myconf} --with-upstype=apcsmart --with-upscable=apcsmart --disable-usb"

	# We force the DISTNAME to gentoo so it will use gentoo's layout also
	# when installed on non-linux systems.
	DISTNAME=gentoo APCUPSD_MAIL=/usr/sbin/sendmail ./configure \
		--prefix=/usr \
		--sbindir=/sbin \
		--sysconfdir=${XSYSCONFDIR} \
		--with-pwrfail-dir=${XPWRFAILDIR} \
		--with-lock-dir=${XLOCKDIR} \
		--with-pid-dir=${XPIDDIR} \
		--with-log-dir=${XLOGDIR} \
		--with-net-port=6666 \
		--with-nis-port=3551 \
		--enable-net \
		--enable-oldnet \
		--enable-master-slave \
		$(use_enable ncurses powerflute) \
		$(use_enable threads pthreads) \
		$(use_enable snmp net-snmp) \
		$(use_enable nls) \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "installed failed"
	rm -f "${D}"/etc/init.d/halt

	if use cgi; then
		if use apache2; then
			insinto ${APACHE2_MODULES_CONFDIR}
			newins ${FILESDIR}/${PV}/apache.conf 60_apcupsd.conf
		fi

		if use lighttpd; then
			insinto /etc/lighttpd
			newins ${FILESDIR}/${PV}/apcupsd-lighttpd.conf apcupsd.conf
			einfo "The configuration file ${ROOT}/etc/lighttpd/apcupsd.conf should"
			einfo "be included in lighttpd.conf configuration file to enable apcupsd"
			einfo "alias and cgi execution."
		fi
	fi

	insinto /etc/apcupsd
	newins examples/safe.apccontrol safe.apccontrol

	cd ${D}/etc/apcupsd

	ln -s onbattery powerout

	if use doc; then
		einfo "Installing full documentation into /usr/share/doc/${P}..."
		cd ${S}/doc
		dodoc README.*
		docinto developers_manual
		dodoc developers_manual/*
		docinto logo
		dodoc logo/*
		docinto manual
		dodoc manual/*
		docinto old_documents
		dodoc old_documents/*
		docinto vim
		dodoc vim/*
	fi
}
