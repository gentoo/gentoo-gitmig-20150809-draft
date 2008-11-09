# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khangman/khangman-4.1.3.ebuild,v 1.1 2008/11/09 01:31:05 scarabeus Exp $

EAPI="2"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="Classical hangman game for KDE"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/keduvocdocument"
