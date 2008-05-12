# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwalletmanager/kwalletmanager-3.5.9.ebuild,v 1.3 2008/05/12 14:34:32 armin76 Exp $

KMNAME=kdeutils
KMMODULE=kwallet
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdeutils-3.5-patchset-01.tar.bz2"

DESCRIPTION="KDE Wallet Management Tool"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
