# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ksplash-ml/ksplash-ml-0.95.3.ebuild,v 1.11 2004/07/06 11:57:56 carlo Exp $

inherit kde

S=${WORKDIR}/ksplashml-${PV}

DESCRIPTION="Fancy splash-screen for KDE 3.x"
SRC_URI="http://www.shadowcom.net/Software/ksplash-ml/ksplashml-${PV}.tgz"
HOMEPAGE="http://www.shadowcom.net/Software/ksplash-ml"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc alpha ia64"
IUSE=""

DEPEND=">=kde-base/kdebase-3.0"
RDEPEND=">=kde-base/kdebase-3.0"
need-kde 3

src_install() {

	kde_src_install

	dodir /etc/env.d
	echo "KSPLASH=${PREFIX}/bin/ksplash" > ${D}/etc/env.d/90ksplash-ml

}
