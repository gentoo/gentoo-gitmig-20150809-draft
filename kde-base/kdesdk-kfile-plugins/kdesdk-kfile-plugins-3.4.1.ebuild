# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kfile-plugins/kdesdk-kfile-plugins-3.4.1.ebuild,v 1.6 2005/07/28 21:16:15 danarmak Exp $

KMNAME=kdesdk
KMMODULE="kfile-plugins"
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins for .cpp, .h, .diff and .ts files"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""
