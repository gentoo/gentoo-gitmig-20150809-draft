# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $ Header: $

inherit kde-base || die

need-kde 3

S=${WORKDIR}/ksplashml-${PV}
DESCRIPTION="Fancy splash-screen for KDE 3.x"
SRC_URI="http://www.shadowcom.net/Software/ksplash-ml/ksplashml-${PV}.tgz"
HOMEPAGE="http://www.shadowcom.net/Software/ksplash-ml"

newdepend ">=kde-base/kdebase-3.0"

LICENSE="ksplash-ml"

KEYWORDS="x86"
