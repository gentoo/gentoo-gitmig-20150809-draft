# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/renamedlg-audio/renamedlg-audio-3.4.0.ebuild,v 1.3 2005/03/25 00:45:41 weeve Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="renamedlgplugins/audio"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE RenameDlg plugin for audio files"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""
DEPEND=""

