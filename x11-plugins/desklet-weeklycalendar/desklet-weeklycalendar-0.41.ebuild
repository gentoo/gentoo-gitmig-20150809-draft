# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-weeklycalendar/desklet-weeklycalendar-0.41.ebuild,v 1.3 2006/10/06 16:03:09 nixnut Exp $

inherit gdesklets

DESKLET_NAME="WeeklyCalendar"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}

DESCRIPTION="A weekly calendar with task management capability"
HOMEPAGE="http://gdesklets.org/?mod=project/uview&pid=24"
SRC_URI="http://gdesklets.org/projects/24/releases/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.35"
