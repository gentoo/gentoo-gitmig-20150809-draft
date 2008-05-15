# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepasswd/kdepasswd-3.5.9.ebuild,v 1.6 2008/05/15 12:34:22 corsair Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-06.tar.bz2"

DESCRIPTION="KDE GUI for passwd"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

KMCOPYLIB="libkonq libkonq"
KMNODOCS=true
