# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesktop/kdesktop-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:31 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The KDE desktop"
KEYWORDS="~x86"
IUSE=""

DEPEND="$DEPEND
$(deprange-dual $PV $MAXKDEVER kde-base/libkonq)
$(deprange-dual $PV $MAXKDEVER kde-base/kdm)
$(deprange-dual $PV $MAXKDEVER kde-base/kcontrol)"
	# Requires the desktop background settings module, 
	# so until we separate the kcontrol modules into separate ebuilds :-),
	# there's a dep here
RDEPEND="${DEPEND}
$(deprange-dual $PV $MAXKDEVER kde-base/kcheckpass)
	sys-apps/eject"

KMCOPYLIB="libkonq libkonq/"
KMEXTRACTONLY="kcheckpass/kcheckpass.h
	libkonq/
	kdm/kfrontend/themer/"
KMCOMPILEONLY="kcontrol/background
	kdmlib/"
KMNODOCS=true

src_install() {
	# ugly, needs fixing: don't install kcontrol/background
	kde-meta_src_install

	rmdir ${D}/${PREFIX}/share/templates/.source/emptydir
}

pkg_postinst() {
	mkdir -p ${PREFIX}/share/templates/.source/emptydir
}
