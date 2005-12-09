# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kfile-plugins/kdesdk-kfile-plugins-3.4.1.ebuild,v 1.8 2005/12/09 10:10:37 josejx Exp $

KMNAME=kdesdk
KMMODULE="kfile-plugins"
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins for .cpp, .h, .diff and .ts files"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
