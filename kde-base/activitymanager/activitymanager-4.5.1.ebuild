# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/activitymanager/activitymanager-4.5.1.ebuild,v 1.5 2010/09/14 17:03:08 josejx Exp $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Activity manager"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

KMEXTRACTONLY="
	nepomuk/services/activities/org.kde.nepomuk.ActivitiesService.xml
"
