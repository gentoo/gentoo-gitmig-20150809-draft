# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knewsticker/knewsticker-3.5.9.ebuild,v 1.6 2008/05/14 16:43:44 corsair Exp $

KMNAME=kdenetwork
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="kicker plugin: rss news ticker"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=">=kde-base/librss-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMCOPYLIB="librss librss"
KMEXTRACTONLY="librss"
