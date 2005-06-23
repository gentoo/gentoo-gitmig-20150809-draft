# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-pppoe/rp-pppoe-3.5-r11.ebuild,v 1.4 2005/06/23 13:51:35 nigoro Exp $

inherit eutils

DESCRIPTION="A user-mode PPPoE client and server suite for Linux"
HOMEPAGE="http://www.roaringpenguin.com/"
SRC_URI="http://www.roaringpenguin.com/penguin/pppoe/${P}.tar.gz
	ftp://ftp.samba.org/pub/ppp/ppp-2.4.3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa mips ppc sparc x86 ~ppc64"
IUSE="X tcltk"

DEPEND="net-dialup/ppp
	X? ( tcltk? (
		virtual/x11
		dev-lang/tcl
		dev-lang/tk ) )"

src_unpack() {
	unpack ${A} || die "failed to unpack"
	cd ${S} || die "${S} not found"

	# Patch to enable integration of adsl-start and adsl-stop with
	# baselayout-1.11.x so that the pidfile can be found reliably per interface
	#These 2 patches should be merged some day
	epatch ${FILESDIR}/${P}-gentoo-netscripts.patch

	epatch ${FILESDIR}/${P}-dsa-557.patch #66296
	epatch ${FILESDIR}/${P}-username-charset.patch #82410
	epatch ${FILESDIR}/${P}-on-demand-with-plugin.patch #85535 and #89609

	#Avoid "setXid, dynamically linked and using lazy bindings" QA notice
	sed -i -e 's:\(@CC@\) \(-o pppoe-wrapper wrapper.o\):\1 -Wl,-z,now \2:' gui/Makefile.in

	# sanbdox violation workaround
	sed -i -e 's/modprobe/#modprobe/' src/configure || die "sed failed"
}

src_compile() {
	addpredict /dev/ppp

	cd ${S}/src
	econf --enable-plugin=../../ppp-2.4.3 || die "econf failed"
	emake || die "emake failed"

	if use X && use tcltk; then
		make -C ${S}/gui || die "gui make failed"
	fi
}

src_install () {
	cd ${S}/src
	make RPM_INSTALL_ROOT=${D} docdir=/usr/share/doc/${PF} install \
		|| die "install failed"

	#Don't use compiled rp-pppoe plugin; use it from the current version of pppd
	rm ${D}/etc/ppp/plugins/rp-pppoe.so
	local PPPD_VER=`best_version net-dialup/ppp`
	PPPD_VER=${PPPD_VER#*/*-} #reduce it to ${PV}-${PR}
	PPPD_VER=${PPPD_VER%%-*} #reduce it to ${PV}
	if [ -n "${PPPD_VER}" ] && [ -f ${ROOT}/usr/lib/pppd/${PPPD_VER}/rp-pppoe.so ] ; then
		dosym /usr/lib/pppd/${PPPD_VER}/rp-pppoe.so /etc/ppp/plugins/rp-pppoe.so
	fi

	prepalldocs

	if use X && use tcltk; then
		make -C ${S}/gui install RPM_INSTALL_ROOT=${D} \
		datadir=/usr/share/doc/${PF}/ || die "gui install failed"
		dosym /usr/share/doc/${PF}/tkpppoe /usr/share/tkpppoe
	fi
}

pkg_postinst() {
	einfo "Use adsl-setup to configure your dialup connection"
}
