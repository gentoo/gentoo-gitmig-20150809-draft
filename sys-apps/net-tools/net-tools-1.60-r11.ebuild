# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.60-r11.ebuild,v 1.7 2005/03/29 23:12:22 vapier Exp $

inherit flag-o-matic toolchain-funcs eutils

PVER=1.1
DESCRIPTION="Standard Linux networking tools"
HOMEPAGE="http://sites.inka.de/lina/linux/NetTools/"
SRC_URI="http://www.tazenda.demon.co.uk/phil/net-tools/${P}.tar.bz2
	mirror://gentoo/${P}-patches-${PVER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86"
IUSE="nls build static"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/patch
	cp ${WORKDIR}/extra/config.{h,make} .
	cp ${WORKDIR}/extra/ether-wake.c .
	cp ${WORKDIR}/extra/ether-wake.8 man/en_US/
	mkdir include/linux
	cp ${WORKDIR}/extra/if_infiniband.h include/linux/

	if use static ; then
		append-flags -static
		append-ldflags -static
	fi

	sed -i \
		-e "/^COPTS =/s:=:=${CFLAGS}:" \
		-e "/^LOPTS =/s:=:=${LDFLAGS}:" \
		Makefile || die "sed FLAGS Makefile failed"

	if ! use nls ; then
		sed -i \
			-e '/define I18N/s:1$:0:' config.h \
			|| die "sed config.h failed"
		sed -i \
			-e '/^I18N=/s:1$:0:' config.make \
			|| die "sed config.make failed"
	fi
}

src_compile() {
	tc-export CC
	emake libdir || die "emake libdir failed"
	emake || die "emake failed"
	emake ether-wake || die "ether-wake failed to build"

	if use nls ; then
		emake i18ndir || die "emake i18ndir failed"
	fi
}

src_install() {
	make BASEDIR="${D}" install || die "make install failed"
	dosbin ether-wake || die "dosbin failed"
	mv "${D}"/bin/* "${D}"/sbin || die "mv failed"
	mv "${D}"/sbin/{hostname,domainname,netstat,dnsdomainname,ypdomainname,nisdomainname} "${D}"/bin \
		|| die "mv failed"
	dodir /usr/bin
	dosym /bin/hostname /usr/bin/hostname

	if ! use build ; then
		dodoc README README.ipv6 TODO
	else
		# only install /bin/hostname
		rm -rf "${D}"/usr "${D}"/sbin
		rm -f "${D}"/bin/{domainname,netstat,dnsdomainname,ypdomainname,nisdomainname}
	fi
}
