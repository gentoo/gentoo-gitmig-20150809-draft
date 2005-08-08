# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdialog/kdialog-3.4.1.ebuild,v 1.10 2005/08/08 22:15:49 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDialog can be used to show nice dialog boxes from shell scripts"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/eject"

KMNODOCS=true

src_install() {
	kde-meta_src_install
	# see bug 89867
	cp ${FILESDIR}/kdeeject-${PV} ${T}/kdeeject
	into ${PREFIX}
	dobin ${T}/kdeeject
}
