# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apcupsd/apcupsd-3.10.5.ebuild,v 1.4 2003/06/21 21:19:38 drobbins Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="APC UPS daemon with integrated tcp/ip remote shutdown"
SRC_URI="mirror://sourceforge/apcupsd/${P}.tar.gz
	ftp://ftp.apcupsd.com/pub/apcupsd/contrib/gd1.2.tar.gz"
HOMEPAGE="http://www.sibbald.com/apcupsd/"
KEYWORDS="x86 amd64 ~ppc arm"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-apps/baselayout-1.8.4
	virtual/glibc
	virtual/mta
	sys-libs/ncurses"

XPIDDIR=/var/run
XLOGDIR=/var/log
XLOCKDIR=/var/lock
XSYSCONFDIR=/etc/apcupsd
XPWRFAILDIR=${XSYSCONFDIR}

src_unpack() {
	unpack ${A}
	cp -a ${WORKDIR}/gd1.2 ${S}/src/
#	cp -a ${S} ${S}-orig
}

src_compile() {
	MAIL=/usr/sbin/sendmail ./configure \
		--prefix=/usr \
		--sbindir=/usr/sbin \
		--sysconfdir=${XSYSCONFDIR} \
		--with-pwrfail-dir=${XPWRFAILDIR} \
		--with-lock-dir=${XLOCKDIR} \
		--with-pid-dir=${XPIDDIR} \
		--with-log-dir=${XLOGDIR} \
		--with-upstype=usb \
		--with-upscable=usb \
		--with-serial-dev=/dev/usb/hid/hiddev[0-9] \
		--with-net-port=6666 \
		--with-nis-port=3551 \
		--enable-usb \
		--enable-net \
		--enable-powerflute \
		--enable-pthreads \
		--with-css-dir=/home/httpd/apcupsd \
		--with-cgi-bin=/home/httpd/apcupsd \
		--enable-cgi \
		|| die
	make || die
}

src_install () {
	make DESTDIR=${D} install

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
}

