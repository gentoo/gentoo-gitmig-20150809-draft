# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/openmcu/openmcu-1.1.7.ebuild,v 1.6 2004/09/06 18:59:44 ciaranm Exp $

inherit eutils

IUSE=""

DESCRIPTION="H.323 conferencing server"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.openh323.org/bin/openmcu_${PV}.tar.gz"

S=${WORKDIR}/openmcu

SLOT="0"
KEYWORDS="~x86"
LICENSE="MPL-1.0"

# get the name of the os
MY_OS="`uname -s | tr [:upper:] [:lower:]`"

DEPEND=">=net-libs/openh323-1.12.2-r1"

src_unpack() {
	unpack ${A}

	# do some include fixing (again...)
	cd ${S}
	epatch ${FILESDIR}/${P}-include.diff
	epatch ${FILESDIR}/${P}-log-config.diff
}

src_compile() {

	CFLAGS="${CFLAGS} -DLOGGING=1" \
	PWLIBDIR=/usr/share/pwlib \
	OPENH323DIR=/usr/share/openh323 \
	emake opt || die
}

src_install() {
	dodir /usr/sbin /var/log/openmcu
	dosbin obj_${MY_OS}_${ARCH}_r/openmcu
	keepdir /var/log/openmcu

	doman openmcu.1
	dodoc ReadMe.txt mpl-1.0.htm

	exeinto /etc/init.d
	newexe ${FILESDIR}/openmcu.rc6 openmcu

	insinto /etc/conf.d
	newins ${FILESDIR}/openmcu.confd openmcu
}

pkg_postinst() {
	einfo "this patched version of openmcu stores it's configuration"
	einfo "in \"/etc/openmcu.ini\" you can generate this file by doing:"
	einfo "    openmcu <options_you_want> --save"
	einfo "or you can add your options to /etc/conf.d/openmcu"
	ewarn "but be careful with removing --disable-menu (this will break"
	ewarn "the openmcu init script)"
	epause 10
}
