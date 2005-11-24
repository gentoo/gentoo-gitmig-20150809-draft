# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility-iconthemes/kdeaccessibility-iconthemes-3.4.3.ebuild,v 1.2 2005/11/24 17:53:17 gustavoz Exp $

KMMODULE=IconThemes
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Icon themes for kde from the kdeaccessibility module"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
DEPEND=""
