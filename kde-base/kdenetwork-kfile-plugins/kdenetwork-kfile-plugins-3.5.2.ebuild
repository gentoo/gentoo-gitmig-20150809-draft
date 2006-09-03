# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-kfile-plugins/kdenetwork-kfile-plugins-3.5.2.ebuild,v 1.11 2006/09/03 16:42:38 kloeri Exp $

KMNAME=kdenetwork
KMMODULE=kfile-plugins
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from the kdenetwork package. Currently provides a torrent kfile plugin."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
