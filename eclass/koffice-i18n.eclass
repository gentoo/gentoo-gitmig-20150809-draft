# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/koffice-i18n.eclass,v 1.3 2001/12/11 20:41:03 danarmak Exp $
inherit kde || die
ECLASS=koffice-i18n

SRC_PATH="kde/stable/koffice-${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

S=${WORKDIR}/${PN}
DESCRIPTION="KOffice ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.koffice.org/"

DEPEND=">=app-office/koffice-${PV}"

myconf="$myconf --enable-final"
