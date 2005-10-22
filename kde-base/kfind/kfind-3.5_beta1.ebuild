# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfind/kfind-3.5_beta1.ebuild,v 1.2 2005/10/22 06:57:52 halcy0n Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE file find utility"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkonq)"
OLDDEPEND="~kde-base/libkonq-$PV"

KMCOPYLIB="libkonq libkonq"
