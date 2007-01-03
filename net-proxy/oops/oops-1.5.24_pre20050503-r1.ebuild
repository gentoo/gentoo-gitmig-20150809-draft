# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/oops/oops-1.5.24_pre20050503-r1.ebuild,v 1.7 2007/01/03 13:07:56 mrness Exp $

inherit eutils flag-o-matic

MY_P="${PN}-1.5.23"

DESCRIPTION="An advanced multithreaded caching web proxy"
HOMEPAGE="http://zipper.paco.net/~igor/oops.eng/"
SRC_URI="http://zipper.paco.net/~igor/oops/${MY_P}.tar.gz
	mirror://gentoo/${P}.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 sparc x86"
IUSE=""

RDEPEND="dev-libs/libpcre
	>=sys-libs/db-3"
DEPEND="${RDEPEND}
	sys-devel/flex"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup oops
	enewuser oops -1 -1 /var/lib/oops oops
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${WORKDIR}/${P}.patch"
	epatch "${FILESDIR}/${P/_*}-textrel.patch"
	epatch "${FILESDIR}/${P/_*}-pthread-rwlock.patch"
	epatch "${FILESDIR}/modules-as-needed.patch"
	sed -i -e 's:/usr/local/lib/libpcre:/usr/lib/libpcre:g' configure
	sed -i -e 's:y\.tab\.h:y.tab.c:' src/Makefile.in
}

src_compile() {
	./configure \
		--prefix=/usr \
		--libdir=/usr/lib/oops \
		--enable-oops-user=oops \
		--sysconfdir=/etc/oops \
		--sbindir=/usr/sbin \
		--with-regexp=pcre \
		--localstatedir=/var/run/oops \
		--enable-large-files \
	|| die "configure problem"

	sed -i -e '/STRERROR_R/d' src/config.h.in
	sed -i \
		-e "s|OOPS_LIBDIR = /usr/lib/oops|OOPS_LIBDIR = ${D}/usr/lib/oops|" \
		-e "s|OOPS_SBINDIR = /usr/sbin|OOPS_SBINDIR = ${D}/usr/sbin|" \
		-e "s|OOPS_SYSCONFDIR = /etc/oops|OOPS_SYSCONFDIR = ${D}/etc/oops|" \
		-e "s|OOPS_LOCALSTATEDIR = /var/run/oops|OOPS_LOCALSTATEDIR = ${D}/var/run/oops|" \
		-e "s|OOPSPATH=/usr/oops|OOPSPATH=${D}/usr/oops|" \
		src/Makefile
	sed -i \
		-e "s|^\(LDFLAGS *= *\)${LDFLAGS}|\1$(raw-ldflags)|" \
		src/modules/Makefile #modules makefile use ld directly

	emake || die "compile problem"
}

src_install() {
	dodir /usr/sbin
	einstall || die "install problem"

	newinitd "${FILESDIR}/oops.initd" oops
	diropts -m0750 -o root -g oops
	dodir /etc/oops
	insinto /etc/oops
	doins "${FILESDIR}/oops.cfg"

	diropts -m0755 -o oops -g oops
	keepdir /var/run/oops
	diropts -m0770 -o oops -g oops
	keepdir /var/log/oops
	keepdir /var/lib/oops/storage
	keepdir /var/lib/oops/db

	# cleanups
	rm -rf "${D}/usr/oops"
	rm -rf "${D}/usr/lib/oops/modules"
}

pkg_preinst() {
	pkg_setup # create oops user and group
}

pkg_postinst() {
	#Set proper owner/group if installed from binary package
	chgrp oops "${ROOT}/etc/oops"
	chown -R oops:oops "${ROOT}/var/run/oops" "${ROOT}/var/log/oops" "${ROOT}/var/lib/oops"
}
