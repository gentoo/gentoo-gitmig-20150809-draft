# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/networkstatus/networkstatus-3.5.10.ebuild,v 1.7 2009/07/12 11:16:22 armin76 Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-05.tar.bz2"

DESCRIPTION="KDE network connection status tracking daemon"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
