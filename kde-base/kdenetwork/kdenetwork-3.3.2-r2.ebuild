# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.3.2-r2.ebuild,v 1.10 2006/02/21 18:51:03 carlo Exp $

inherit kde-dist eutils

DESCRIPTION="KDE network apps: kopete, kppp, kget..."

KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="slp samba wifi ssl"

DEPEND="~kde-base/kdebase-${PV}
	slp? ( net-libs/openslp )
	samba? ( net-fs/samba )
	ssl? ( app-crypt/qca-tls )
	wifi? ( <=net-wireless/wireless-tools-28_pre6 )"

SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-3.3.2-kdenetwork-libgadu.patch"

src_unpack() {
	kde_src_unpack

	# Fix to make kopete connect to msn (kde bug 105929). Applied upstream.
	epatch "${FILESDIR}/${P}-kopete-msn.patch"

	# Fix bug #75907. Applied upstream.
	epatch "${DISTDIR}/${P}-kwifimanager-configlocation.patch"

	# Fix vulnerabilities in libgadu. See bug 99754.
	epatch "${DISTDIR}/post-3.3.2-kdenetwork-libgadu.patch"
}

src_compile() {
	myconf="$myconf $(use_enable slp)"
	use wifi || DO_NOT_COMPILE="$DO_NOT_COMPILE wifi"
	export DO_NOT_COMPILE
	kde_src_compile
}

src_install() {
	kde_src_install

	chmod +s ${D}/${KDEDIR}/bin/reslisa

	# empty config file needed for lisa to work with default settings
	touch ${D}/etc/lisarc

	# lisa, reslisa initscripts
	dodir /etc/init.d
	sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/lisa > ${D}/etc/init.d/lisa
	sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/reslisa > ${D}/etc/init.d/reslisa
	chmod +x ${D}/etc/init.d/*

	insinto /etc/conf.d
	newins ${FILESDIR}/lisa.conf lisa
	newins ${FILESDIR}/reslisa.conf reslisa
}
