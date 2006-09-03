# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-xine/artsplugin-xine-3.5.2.ebuild,v 1.12 2006/09/03 10:24:11 kloeri Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=xine_artsplugin
MAXKDEVER=3.5.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="arts xine plugin"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND=">=media-libs/xine-lib-1.0"
