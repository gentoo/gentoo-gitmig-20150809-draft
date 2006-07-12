# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-kfile-plugins/kdeaddons-kfile-plugins-3.4.1.ebuild,v 1.13 2006/07/12 14:28:54 kugelfang Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/"
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kdeaddons kfile plugins"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="ssl"
DEPEND="ssl? ( dev-libs/openssl )"

# kfile-cert requires ssl

