# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-mpg123/artsplugin-mpg123-3.5.0.ebuild,v 1.4 2006/04/28 20:16:58 josejx Exp $

KMNAME=kdemultimedia
KMMODULE=mpg123_artsplugin
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="aRts plugin for mpg123"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
}
