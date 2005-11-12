# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-docs-konq-plugins/kdeaddons-docs-konq-plugins-3.5_beta1.ebuild,v 1.4 2005/11/12 15:49:25 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="doc/konq-plugins"
MAXKDEVER=3.5.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Documentation for the konqueror plugins from kdeaddons"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

