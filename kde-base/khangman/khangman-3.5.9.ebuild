# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khangman/khangman-3.5.9.ebuild,v 1.6 2008/05/15 06:45:30 corsair Exp $
KMNAME=kdeedu
EAPI="1"
inherit kde-meta

DESCRIPTION="Classical hangman game for KDE"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeducore"
KMCOPYLIB="libkdeeducore libkdeedu/kdeeducore"
