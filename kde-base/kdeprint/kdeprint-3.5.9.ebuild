# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeprint/kdeprint-3.5.9.ebuild,v 1.1 2008/02/20 22:53:55 philantrop Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE printer queue/device manager"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="cups kde kdehiddenvisibility"

# TODO Makefile reads ppd models from /usr/share/cups/model	 (hardcoded !!)
DEPEND="cups? ( net-print/cups )"
RDEPEND="${DEPEND}
	app-text/enscript
	app-text/psutils
	kde? ( >=kde-base/kghostview-${PV}:${SLOT} )"

src_compile() {
	myconf="$myconf $(use_with cups)"
	kde-meta_src_compile
}
