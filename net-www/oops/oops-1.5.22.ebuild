# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/oops/oops-1.5.22.ebuild,v 1.6 2004/07/14 06:02:46 mr_bones_ Exp $

DESCRIPTION="An advanced multithreaded caching web proxy"
HOMEPAGE="http://zipper.paco.net/~igor/oops.eng/"
SRC_URI="http://zipper.paco.net/~igor/oops/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

RDEPEND=""
DEPEND="dev-libs/libpcre
	sys-devel/flex"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp configure configure.orig
	sed -e 's:/usr/local/lib/libpcre:/usr/lib/libpcre:g' configure.orig > configure
	cd ${S}/src/modules
}

src_compile() {
	./configure \
		--prefix=/usr \
		--libdir=/usr/lib/oops \
		--enable-oops-user=squid \
		--sysconfdir=/etc/oops \
		--sbindir=/usr/sbin \
		--with-regexp=pcre \
		--localstatedir=/var/run/oops \
	|| die "configure problem"

	cd src
	mv config.h.in config.h.in.orig
	sed <config.h.in.orig >config.h.in \
		-e '/STRERROR_R/d'
	mv Makefile Makefile.orig
	sed <Makefile.orig >Makefile \
		-e "s|OOPS_LIBDIR = /usr/lib/oops|OOPS_LIBDIR = ${D}/usr/lib/oops|" \
		-e "s|OOPS_SBINDIR = /usr/sbin|OOPS_SBINDIR = ${D}/usr/sbin|" \
		-e "s|OOPS_SYSCONFDIR = /etc/oops|OOPS_SYSCONFDIR = ${D}/etc/oops|" \
		-e "s|OOPS_LOCALSTATEDIR = /var/run/oops|OOPS_LOCALSTATEDIR = ${D}/var/run/oops|" \
		-e "s|OOPSPATH=/usr/oops|OOPSPATH=${D}/usr/oops|"
	cd ..
	make || die "compile problem"
}

src_install() {
	local x
	local y

	dodir /usr/sbin
	chown squid:squid ${D}
	make DESTDIR=${D} install || die "install problem"
	chmod -R g+srw ${D}/etc/oops
	chmod -R g+rw ${D}/etc/oops/*

	insinto /etc/oops
	doins ${FILESDIR}/oops.cfg
	cd ${D}

	# cleanups
	rm -rf ${D}/usr/oops
	rm -rf ${D}/usr/lib/oops/modules

	# config files
	cd ${D}/etc/oops
	for y in . tables ; do
		for x in ${y}/* ; do
			if [ -f ${x} ] ; then
				mv ${x} ${x}.eg
			fi
		done
	done
}

pkg_postinst() {
	local x
	local y
	local mylen
	local newf

	cd ${ROOT}/etc/oops
	for y in . tables ; do
		for x in ${y}/*.eg ; do
			realf=`echo $x | sed -e 's/.eg$//'`
			if [ ! -e ${realf} ] ; then
				cp ${x} ${realf}
			fi
		done
	done
	if [ ! -e ${ROOT}/var/log/oops ] ; then
		install -d -o squid -g squid -m0770 ${ROOT}/var/log/oops
		chmod g+s ${ROOT}/var/log/oops
	fi
	if [ ! -e ${ROOT}/var/lib/oops/storage ] ; then
		install -d -o squid -g squid -m0770  ${ROOT}/var/lib/oops/storage
	fi
	if [ ! -e ${ROOT}/var/lib/oops/db ] ; then
		install -d -o squid -g squid -m0770 ${ROOT}/var/lib/oops/db
	fi
	if [ ! -e ${ROOT}/var/run/oops ] ; then
		install -d -o squid -g squid -m0775 ${ROOT}/var/run/oops
		chmod g+s ${ROOT}/var/run/oops
	fi
}
