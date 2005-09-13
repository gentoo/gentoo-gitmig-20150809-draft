# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/renamedlg-audio/renamedlg-audio-3.4.1.ebuild,v 1.9 2005/09/13 14:54:16 agriffis Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="renamedlgplugins/audio"
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE RenameDlg plugin for audio files"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND=""

