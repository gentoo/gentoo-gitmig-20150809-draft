# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-advancednotifications/leechcraft-advancednotifications-0.4.96.ebuild,v 1.1 2011/12/15 19:37:01 maksbotan Exp $

EAPI="2"

inherit leechcraft

DESCRIPTION="Flexible and customizable notifications framework for LeechCraft."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="=net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo "Advanced Notifications supports playing sounds on various"
	einfo "events. Install some media playback plugin to enjoy this"
	einfo "feature (media-video/leechcraft-lmp will do, for example)."
}
