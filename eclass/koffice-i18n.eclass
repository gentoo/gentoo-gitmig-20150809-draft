# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/koffice-i18n.eclass,v 1.22 2003/02/28 09:15:04 vapier Exp $
#
# Author Dan Armak <danarmak@gentoo.org>

inherit kde
ECLASS=koffice-i18n
INHERITED="$INHERITED $ECLASS"

case $PV in
	1 | 1_* | 1.1*)
		need-kde 2.2
		SRC_PATH="stable/koffice-${PV//_/-}/src/${PN}-${PV//_/-}.tar.bz2"
		KEYWORDS="x86"
		;;
	# 1.2 prereleases
	1.2_*)
		need-kde 3
		SRC_PATH="unstable/koffice-${PV//_/-}/src/${PN}-${PV//_/-}.tar.bz2"
		KEYWORDS="x86 ppc"
		;;
	1.2|1.2.1)
		need-kde 3
		SRC_PATH="stable/koffice-${PV}/src/${P}.tar.bz2"
		KEYWORDS="x86 ppc"
		;;
esac

SRC_URI="mirror://kde/$SRC_PATH"

S=${WORKDIR}/${PN}
DESCRIPTION="KOffice ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"
DEPEND="~app-office/koffice-${PV}"

