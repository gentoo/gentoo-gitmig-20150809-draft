# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdenetwork/libkdenetwork-3.5_beta1.ebuild,v 1.4 2005/11/12 15:49:35 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=3.5.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="library common to many KDE network apps"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=app-crypt/gpgme-1.0.2"
