# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-audiofile/artsplugin-audiofile-3.5.0.ebuild,v 1.17 2006/06/01 21:24:29 flameeyes Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=audiofile_artsplugin
MAXKDEVER=3.5.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="arts audiofile plugin"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="media-libs/audiofile"
