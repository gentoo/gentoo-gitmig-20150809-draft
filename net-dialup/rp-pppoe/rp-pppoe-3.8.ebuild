# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-pppoe/rp-pppoe-3.8.ebuild,v 1.13 2007/01/05 10:18:43 mrness Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils flag-o-matic autotools

DESCRIPTION="A user-mode PPPoE client and server suite for Linux"
HOMEPAGE="http://www.roaringpenguin.com/pppoe/"
SRC_URI="http://www.roaringpenguin.com/penguin/pppoe/${P}.tar.gz
	ftp://ftp.samba.org/pub/ppp/ppp-2.4.3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa mips ppc ppc64 sh sparc x86"
IUSE="X"

DEPEND="net-dialup/ppp
	X? ( dev-lang/tk )"

src_unpack() {
	unpack ${A} || die "failed to unpack"

	# Patch to enable integration of adsl-start and adsl-stop with
	# baselayout-1.11.x so that the pidfile can be found reliably per interface
	epatch "${FILESDIR}/${P}-gentoo-netscripts.patch"

	epatch "${FILESDIR}/${P}-username-charset.patch" #82410
	epatch "${FILESDIR}/${P}-plugin-options.patch"
	epatch "${FILESDIR}/${P}-configure.patch"

	cd "${S}"
	#Avoid "setXid, dynamically linked and using lazy bindings" QA notice
	sed -i -e 's:\(@CC@\) \(-o pppoe-wrapper wrapper.o\):\1 '$(bindnow-flags)' \2:' gui/Makefile.in

	cd src
	eautoconf
}

src_compile() {
	addpredict /dev/ppp

	cd "${S}/src"
	econf --enable-plugin=../../ppp-2.4.3 || die "econf failed"
	emake || die "emake failed"

	if use X; then
		make -C "${S}/gui" || die "gui make failed"
	fi
}

src_install () {
	cd "${S}/src"
	make RPM_INSTALL_ROOT="${D}" docdir=/usr/share/doc/${PF} install \
		|| die "install failed"

	#Don't use compiled rp-pppoe plugin; use it from the current version of pppd
	rm "${D}/etc/ppp/plugins/rp-pppoe.so"
	local PPPD_VER=`best_version net-dialup/ppp`
	PPPD_VER=${PPPD_VER#*/*-} #reduce it to ${PV}-${PR}
	PPPD_VER=${PPPD_VER%%-*} #reduce it to ${PV}
	if [ -n "${PPPD_VER}" ] && [ -f "${ROOT}/usr/lib/pppd/${PPPD_VER}/rp-pppoe.so" ] ; then
		dosym /usr/lib/pppd/${PPPD_VER}/rp-pppoe.so /etc/ppp/plugins/rp-pppoe.so
	fi

	prepalldocs

	if use X; then
		make -C "${S}/gui" install RPM_INSTALL_ROOT="${D}" \
		datadir=/usr/share/doc/${PF}/ || die "gui install failed"
		dosym /usr/share/doc/${PF}/tkpppoe /usr/share/tkpppoe
	fi
}

pkg_postinst() {
	einfo "Use pppoe-setup to configure your dialup connection."
}
