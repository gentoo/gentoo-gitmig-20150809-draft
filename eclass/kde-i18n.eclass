# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-i18n.eclass,v 1.5 2001/11/16 12:50:41 danarmak Exp $
inherit kde kde.org || die
ECLASS=kde-i18n

S=${WORKDIR}/${PN}
DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"

need-kdelibs ${PV}

PROVIDE="virtual/kde-i18n-${PV}"

