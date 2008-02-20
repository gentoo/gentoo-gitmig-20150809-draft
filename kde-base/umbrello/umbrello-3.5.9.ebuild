# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-3.5.9.ebuild,v 1.1 2008/02/20 23:36:35 philantrop Exp $

KMNAME=kdesdk
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI} mirror://gentoo/kdesdk-3.5-patchset-01.tar.bz2"

DESCRIPTION="KDE: Umbrello UML Modeller"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
