# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.0.5b.ebuild,v 1.4 2004/01/19 03:25:39 caleb Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE $PV - network apps: kmail..."
newdepend "~kde-base/kdebase-${PV} dev-lang/perl" # perl is used for ksirc scripting
KEYWORDS="x86 ppc ~alpha sparc"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	kde_sandbox_patch ${S}/kppp
}

src_install() {
	kde_src_install
	chmod +s ${D}/${KDEDIR}/bin/reslisa

	# empty config file needed for lisa to work with default settinsg
	touch ${D}/etc/lisarc

	# lisa, reslisa initscripts
	dodir /etc/init.d
	sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/lisa > ${D}/etc/init.d/lisa
	sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/reslisa > ${D}/etc/init.d/reslisa

	insinto /etc/conf.d
	newins ${FILESDIR}/lisa.conf lisa
	newins ${FILESDIR}/reslisa.conf reslisa
}
