# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/oops/oops-1.5.24_pre20050403.ebuild,v 1.1 2005/05/03 22:33:25 mrness Exp $

inherit eutils

MY_P="${PN}-1.5.23"

DESCRIPTION="An advanced multithreaded caching web proxy"
HOMEPAGE="http://zipper.paco.net/~igor/oops.eng/"
SRC_URI="http://zipper.paco.net/~igor/oops/${MY_P}.tar.gz
	mirror://gentoo/${P}.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="mysql postgres"

RDEPEND="virtual/libc
	dev-libs/libpcre
	>=sys-libs/db-3
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"
DEPEND="${RDEPEND}
	sys-devel/flex"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${WORKDIR}/${P}.patch
	sed -i -e 's:/usr/local/lib/libpcre:/usr/lib/libpcre:g' configure
	sed -i -e 's:y\.tab\.h:y.tab.c:' src/Makefile.in
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
		--enable-large-files \
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
	emake || die "compile problem"
}

src_install() {
	dodir /usr/sbin
	chown squid:squid ${D}
	einstall || die "install problem"
	#chmod -R g+srw ${D}/etc/oops Remove this if proved to work without it

	exeinto /etc/init.d
	newexe ${FILESDIR}/oops.initd ${PN}
	insinto /etc/oops
	doins ${FILESDIR}/oops.cfg

	diropts -m0755 -o squid
	dodir /var/run/oops
	diropts -m0770 -o squid
	dodir /var/log/oops
	dodir /var/lib/oops
	dodir /var/lib/oops/storage
	keepdir /var/lib/oops/storage
	dodir /var/lib/oops/db
	keepdir /var/lib/oops/db

	# cleanups
	rm -rf ${D}/usr/oops
	rm -rf ${D}/usr/lib/oops/modules

	# config files; if already exist, move them to *.eg
	cd ${D}/etc/oops
	local x y
	for y in . tables ; do
		for x in ${y}/* ; do
			if [ -f ${x} ] ; then
				if [ -f ${ROOT}/etc/oops/${x} ]; then
					mv ${x} ${x}.eg
				else
					cp ${x} ${x}.eg
				fi
			fi
		done
	done
}

