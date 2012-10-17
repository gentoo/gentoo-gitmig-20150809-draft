# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solid-runtime/solid-runtime-4.9.2.ebuild,v 1.2 2012/10/17 18:17:27 maekke Exp $

EAPI=4

KMNAME="kde-runtime"
KMNOMODULE=true
inherit kde4-meta

DESCRIPTION="KDE SC solid runtime modules (autoeject, automounter and others)"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

KMEXTRA="
	solid-device-automounter/
	solid-hardware/
	solid-networkstatus/
	solidautoeject/
	soliduiserver/
"

# file collisions, bug 395001
add_blocker solid 4.4.50
