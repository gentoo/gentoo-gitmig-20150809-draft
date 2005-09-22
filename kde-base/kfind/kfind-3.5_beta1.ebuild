# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfind/kfind-3.5_beta1.ebuild,v 1.1 2005/09/22 18:54:55 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE file find utility"
KEYWORDS="~amd64"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkonq)"
OLDDEPEND="~kde-base/libkonq-$PV"

KMCOPYLIB="libkonq libkonq"
