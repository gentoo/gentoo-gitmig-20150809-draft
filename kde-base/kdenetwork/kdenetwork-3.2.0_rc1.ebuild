# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.2.0_rc1.ebuild,v 1.2 2004/01/23 13:42:49 caleb Exp $
inherit kde-dist

IUSE="slp samba"
DESCRIPTION="KDE network apps: kopete, kppp, kget. kmail and knode are now in kdepim."
KEYWORDS="~x86 ~sparc ~amd64"
DEPEND="~kde-base/kdebase-${PV}
	slp? ( net-libs/openslp )
	samba? ( net-fs/samba )
	!net-im/kopete
	!net-wireless/kwifimanager"
RDEPEND="$DEPEND"

myconf="$myconf `use_enable slp`"

src_unpack()
{
	kde_src_unpack
	epatch ${FILESDIR}/${P}.patch
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
