# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-audiofile/artsplugin-audiofile-3.5_beta1.ebuild,v 1.3 2005/10/22 06:18:02 halcy0n Exp $

KMNAME=kdemultimedia
KMMODULE=audiofile_artsplugin
MAXKDEVER=3.5.0_beta2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="arts audiofile plugin"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="media-libs/audiofile"

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
}