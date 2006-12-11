# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-audiofile/artsplugin-audiofile-3.5.4.ebuild,v 1.9 2006/12/11 12:55:27 kloeri Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=audiofile_artsplugin
MAXKDEVER=3.5.5
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="arts audiofile plugin"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="media-libs/audiofile"
