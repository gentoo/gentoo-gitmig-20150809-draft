# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.1.4.ebuild,v 1.8 2003/12/28 03:43:36 caleb Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE network apps: kmail, kppp, knode..."
KEYWORDS="x86 ppc sparc hppa amd64"
DEPEND="~kde-base/kdebase-${PV}"
RDEPEND="$DEPEND"

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
