# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfile-cert/kfile-cert-3.4.0_beta2.ebuild,v 1.1 2005/02/05 18:34:18 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/cert"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kfile plugin for cerificate files"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-libs/openssl"

