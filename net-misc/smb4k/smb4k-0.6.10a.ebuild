# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smb4k/smb4k-0.6.10a.ebuild,v 1.1 2006/12/22 11:38:45 flameeyes Exp $

inherit kde

MY_P=${P/_/}
PREV_PV="${PV/a/}"

DESCRIPTION="Smb4K is a SMB share browser for KDE 3.2.x."
HOMEPAGE="http://smb4k.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${PN}-${PREV_PV}.tar.gz
	mirror://berlios/${PN}/${PN}-${PREV_PV}_to_${PV}.tar.gz
	mirror://berlios/${PN}/003_security_fix_${PN}_${PV}.diff.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| ( kde-base/konqueror kde-base/kdebase )"
RDEPEND="${DEPEND}
	net-fs/samba"
need-kde 3.4

S="${WORKDIR}/${PN}-${PREV_PV}"

PATCHES="${WORKDIR}/${PN}-${PREV_PV}_to_${PV}.diff
	${DISTDIR}/003_security_fix_${PN}_${PV}.diff.bz2"
