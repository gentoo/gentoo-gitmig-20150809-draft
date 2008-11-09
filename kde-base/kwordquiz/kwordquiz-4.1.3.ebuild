# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwordquiz/kwordquiz-4.1.3.ebuild,v 1.1 2008/11/09 02:03:09 scarabeus Exp $

EAPI="2"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE: A powerful flashcard and vocabulary learning program"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"

KMEXTRACTONLY="libkdeedu/keduvocdocument"
