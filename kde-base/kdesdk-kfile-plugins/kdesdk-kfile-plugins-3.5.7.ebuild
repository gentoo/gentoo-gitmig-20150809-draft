# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kfile-plugins/kdesdk-kfile-plugins-3.5.7.ebuild,v 1.6 2007/08/11 11:22:34 philantrop Exp $

KMNAME=kdesdk
KMMODULE="kfile-plugins"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins for .cpp, .h, .diff and .ts files"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
