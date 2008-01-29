# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-3.5.8-r1.ebuild,v 1.3 2008/01/29 17:35:14 armin76 Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-09.tar.bz2"

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

src_unpack() {
	kde-meta_src_unpack
	sed -i -e "s:SUBDIRS = viewer test:SUBDIRS = viewer:" "${S}/nsplugins/Makefile.am" || die "sed failed"
}
