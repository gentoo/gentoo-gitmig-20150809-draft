# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-mpg123/artsplugin-mpg123-3.5.0.ebuild,v 1.9 2006/05/30 05:09:31 josejx Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=mpg123_artsplugin
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="aRts plugin for mpg123"
KEYWORDS="amd64 ppc x86"
IUSE=""
