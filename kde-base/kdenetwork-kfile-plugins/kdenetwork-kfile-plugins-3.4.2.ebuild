# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-kfile-plugins/kdenetwork-kfile-plugins-3.4.2.ebuild,v 1.10 2006/03/27 14:04:24 agriffis Exp $

KMNAME=kdenetwork
KMMODULE=kfile-plugins
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from the kdenetwork package. Currently provides a torrent kfile plugin."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
