# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-docs-kate-plugins/kdeaddons-docs-kate-plugins-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:29 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="doc/kate-plugins"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="documentation for all kate plugins from kdeaddons"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

