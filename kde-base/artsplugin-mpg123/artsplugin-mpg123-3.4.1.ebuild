# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-mpg123/artsplugin-mpg123-3.4.1.ebuild,v 1.13 2006/05/30 01:12:22 flameeyes Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=mpg123_artsplugin
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="aRts plugin for mpg123"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

PATCHES="${FILESDIR}/artsplugin-mpg123-mcpu.patch"

