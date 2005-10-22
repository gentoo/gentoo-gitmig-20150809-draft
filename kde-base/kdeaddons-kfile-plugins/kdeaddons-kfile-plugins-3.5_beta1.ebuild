# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-kfile-plugins/kdeaddons-kfile-plugins-3.5_beta1.ebuild,v 1.3 2005/10/22 06:37:26 halcy0n Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/"
MAXKDEVER=3.5.0_beta2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kdeaddons kfile plugins"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="ssl? ( dev-libs/openssl )"

# kfile-cert requires ssl

