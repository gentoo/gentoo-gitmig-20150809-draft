# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/apcupsd/apcupsd-3.10.17.ebuild,v 1.2 2005/03/28 18:39:11 tantive Exp $

inherit eutils depend.apache

need_apache

DESCRIPTION="APC UPS daemon with integrated tcp/ip remote shutdown"
HOMEPAGE="http://www.sibbald.com/apcupsd/"
SRC_URI="mirror://sourceforge/apcupsd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="doc snmp usb apache2 cgi threads ncurses nls"

DEPEND="virtual/libc
	snmp? ( net-analyzer/net-snmp )
	cgi? ( >=media-libs/gd-1.8.4
		net-www/apache )
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
		--sbindir=/usr/sbin \
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
	make || die
}

src_install () {
	make DESTDIR=${D} install || die "installed failed"

	if use cgi; then
		insinto ${APACHE_MODULEDIR}
		newins ${FILEDIR}/${PV}/apache.conf 60_apcupsd.conf
	fi

	insinto /etc/apcupsd
	newins examples/safe.apccontrol safe.apccontrol

	cd ${D}/etc/apcupsd
	epatch ${FILESDIR}/${PV}/smtp.patch

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
