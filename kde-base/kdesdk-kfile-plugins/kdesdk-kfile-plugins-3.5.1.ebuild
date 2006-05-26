# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kfile-plugins/kdesdk-kfile-plugins-3.5.1.ebuild,v 1.5 2006/05/26 17:00:48 wolf31o2 Exp $

KMNAME=kdesdk
KMMODULE="kfile-plugins"
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins for .cpp, .h, .diff and .ts files"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""
