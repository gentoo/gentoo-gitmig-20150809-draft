# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystraycmd/ksystraycmd-3.5.5.ebuild,v 1.12 2007/07/11 01:08:47 mr_bones_ Exp $

KMNAME=kdebase
MAXKDEVER=3.5.7
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-03.tar.bz2"

DESCRIPTION="ksystraycmd embeds applications given as argument into the system tray."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
