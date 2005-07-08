# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-3.4.1.ebuild,v 1.6 2005/07/08 03:16:26 weeve Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Netscape plugins support for konqueror"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""


