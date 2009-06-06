# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-3.5.10.ebuild,v 1.4 2009/06/06 09:43:26 maekke Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-13.tar.bz2"

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND="x11-libs/libXt
	=dev-libs/glib-2*"

src_unpack() {
	kde-meta_src_unpack

	sed -i -e "s:SUBDIRS = viewer test:SUBDIRS = viewer:" \
		"${S}/nsplugins/Makefile.am" || die "sed failed"
}
