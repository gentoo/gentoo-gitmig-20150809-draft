# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.3.2-r2.ebuild,v 1.11 2006/07/11 18:46:13 flameeyes Exp $

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

pkg_postinst() {
	elog "Since 11 July 2006 the version of Kopete here built cannot connect to ICQ service"
	elog "anymore."
	elog "You're currently invited to use either >=kde-base/kopete-3.5.3-r2, >=net-im/kopete-0.12.0-r2"
	elog "or >=kde-base/kdenetwork-3.5.2-r2 that are patched to support the new authentication."
	elog "For more information, please look at the following bugs:"
	elog "	  http://bugs.kde.org/show_bug.cgi?id=130630"
	elog "	  http://bugs.gentoo.org/show_bug.cgi?id=140009"
}
