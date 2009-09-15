# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-WeeklyCalendar/desklet-WeeklyCalendar-0.50.ebuild,v 1.1 2009/09/15 01:37:47 nixphoeni Exp $

DESKLET_NAME="${PN#desklet-}"

inherit gdesklets

DESCRIPTION="A weekly calendar with task management capability"
HOMEPAGE="http://gdesklets.de/?q=desklet/view/111"
LICENSE="GPL-3"

SLOT="0"
IUSE=""
# KEYWORDS are limited by dev-python/icalendar
KEYWORDS="~amd64 ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.36.1
	>=x11-plugins/desklet-iCalendarEvent-0.3"

DOCS="README"
