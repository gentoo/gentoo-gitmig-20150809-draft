# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-docs-konq-plugins/kdeaddons-docs-konq-plugins-3.5.4.ebuild,v 1.10 2006/12/11 11:32:57 kloeri Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="doc/konq-plugins"
MAXKDEVER=3.5.5
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Documentation for the konqueror plugins from kdeaddons"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=""

