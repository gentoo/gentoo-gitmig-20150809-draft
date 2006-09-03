# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-audiofile/artsplugin-audiofile-3.5.0.ebuild,v 1.19 2006/09/03 10:25:24 kloeri Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=audiofile_artsplugin
MAXKDEVER=3.5.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="arts audiofile plugin"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="media-libs/audiofile"
