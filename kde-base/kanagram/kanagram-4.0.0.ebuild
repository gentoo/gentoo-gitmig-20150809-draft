# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kanagram/kanagram-4.0.0.ebuild,v 1.1 2008/01/17 23:32:09 philantrop Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE: letter order game."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
DEPEND="${DEPEND} ${COMMONDEPEND}"
RDEPEND="${RDEPEND} ${COMMONDEPEND}
	|| ( >=kde-base/phonon-${PV}:${SLOT}
		>=kde-base/kdebase-${PV}:${SLOT} )"

KMEXTRACTONLY="libkdeedu/kdeeduui libkdeedu/keduvocdocument"
