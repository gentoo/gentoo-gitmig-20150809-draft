# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdialog/kdialog-3.5_alpha1.ebuild,v 1.1 2005/09/07 11:34:30 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDialog can be used to show nice dialog boxes from shell scripts"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/eject"

KMNODOCS=true

src_install() {
	kde-meta_src_install
	# see bug 89867
#	cp ${FILESDIR}/kdeeject-${PV} ${T}/kdeeject
#	into ${PREFIX}
#	dobin ${T}/kdeeject
}
