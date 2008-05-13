# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khelpcenter/khelpcenter-3.5.9.ebuild,v 1.5 2008/05/13 03:49:00 jer Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-04.tar.bz2"

DESCRIPTION="The KDE help center."
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

KMEXTRA="doc/faq
	doc/glossary
	doc/quickstart
	doc/userguide
	doc/visualdict"

RDEPEND=">=kde-base/kdebase-kioslaves-${PV}:${SLOT}
		>=www-misc/htdig-3.2.0_beta6-r1"
