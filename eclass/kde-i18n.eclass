# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-i18n.eclass,v 1.10 2002/01/05 20:17:45 danarmak Exp $
inherit kde kde.org 
ECLASS=kde-i18n

S=${WORKDIR}/${PN}
DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"

need-kde ${PV}

PROVIDE="virtual/kde-i18n-${PV}"

myconf="$myconf --enable-final"

SRC_URI="$SRC_URI http://www.ibiblio.org/gentoo/distfiles/kde-i18n-gentoo.patch"

src_unpack() {
    unpack ${A//kde-i18n-gentoo.patch}
    cd ${S}
    patch -p0 < ${DISTDIR}/kde-i18n-gentoo.patch
}