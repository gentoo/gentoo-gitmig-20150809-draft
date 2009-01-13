# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knotify/knotify-4.1.4.ebuild,v 1.1 2009/01/13 22:28:05 alexxy Exp $

EAPI="2"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="The KDE notification daemon."
IUSE="debug"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND="media-sound/phonon"
RDEPEND="${DEPEND}"
