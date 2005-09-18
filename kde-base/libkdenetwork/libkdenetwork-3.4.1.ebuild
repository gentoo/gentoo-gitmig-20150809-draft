# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdenetwork/libkdenetwork-3.4.1.ebuild,v 1.10 2005/09/18 14:52:27 caleb Exp $

KMNAME=kdepim
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="library common to many KDE network apps"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND=">=app-crypt/gpgme-1.0.2"
