# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/periodic-calendar/periodic-calendar-2.2.ebuild,v 1.1 2008/10/02 03:05:01 darkside Exp $

inherit gnome2 eutils

MY_PN="PeriodicCalendar"
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A GUI utility which assists in menstrual cycle tracking and fertility periods prediction."

HOMEPAGE="http://linuxorg.sourceforge.net/"
SRC_URI="mirror://sourceforge/linuxorg/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.1.0
		>=gnome-base/gconf-1.1.11
		>=dev-cpp/gtkmm-2.4.0
		>=dev-cpp/libglademm-2.4.0"

DEPEND="${RDEPEND}
		>=dev-util/intltool-0.29
		>=app-text/scrollkeeper-0.1.4
		dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING* INSTALL README"

pkg_postinst() {
	ewarn "It's probably a good idea that you read the documentation for this package."
	ewarn "But just in case: From the README..."
	echo
	ewarn "At this point the fertility prediction is based on the calendar method"
	ewarn "which is not very precise. It is not recommended to use this method alone"
	ewarn "for the birth control."
	ewarn "THIS PROGRAM PREDICTIONS IN NO CASES CAN BE USED AS THE FINAL. THE METHODS USE"
	ewarn "ARE NOT 100% EFFECTIVE FOR ALL WOMEN."
	echo
	ebeep 3

}
