# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.3.1-r1.ebuild,v 1.4 2004/12/05 22:06:33 eradicator Exp $

inherit kde-dist eutils

DESCRIPTION="KDE network apps: kopete, kppp, kget..."

KEYWORDS="x86 ~amd64 ~ppc64 sparc ppc ~hppa alpha"
IUSE="slp samba wifi ssl"

DEPEND="~kde-base/kdebase-${PV}
	slp? ( net-libs/openslp )
	samba? ( net-fs/samba )
	ssl? ( app-crypt/qca-tls )
	!net-im/kopete
	wifi? ( net-wireless/wireless-tools )
	!net-misc/ksambaplugin"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/3.3.1-kget.diff
}

src_compile() {
	myconf="$myconf `use_enable slp`"
	( use wifi && use arts ) || DO_NOT_COMPILE="$DO_NOT_COMPILE wifi"
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
