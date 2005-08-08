# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdf/kdf-3.4.1.ebuild,v 1.8 2005/08/08 21:56:39 kloeri Exp $

KMNAME=kdeutils
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE free disk space utility"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""