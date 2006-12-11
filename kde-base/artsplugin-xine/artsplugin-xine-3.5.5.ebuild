# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-xine/artsplugin-xine-3.5.5.ebuild,v 1.8 2006/12/11 12:56:03 kloeri Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=xine_artsplugin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="arts xine plugin"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND=">=media-libs/xine-lib-1.0"
