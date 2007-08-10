# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksim/ksim-3.5.7.ebuild,v 1.6 2007/08/10 13:59:26 angelos Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE system monitoring applets."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility snmp"
DEPEND="snmp? ( net-analyzer/net-snmp )"

RDEPEND="${DEPEND}"

src_unpack() {
	kde-meta_src_unpack
	sed -i -e "s:Hidden=true:Hidden=false:" ksim/ksim.desktop
}

src_compile() {
	myconf="$myconf $(use_with snmp)"
	kde-meta_src_compile
}

src_install() {
	kde-meta_src_install
	# see bug 144731
	rm ${D}${KDEDIR}/share/applications/kde/ksim.desktop
}
