# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdenetwork/libkdenetwork-3.5.0.ebuild,v 1.5 2006/01/22 22:53:09 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=3.5.1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="library common to many KDE network apps"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=">=app-crypt/gpgme-1.0.2"
