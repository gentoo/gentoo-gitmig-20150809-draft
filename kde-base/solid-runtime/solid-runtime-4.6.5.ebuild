# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solid-runtime/solid-runtime-4.6.5.ebuild,v 1.2 2011/08/09 17:12:13 hwoarang Exp $

EAPI=4

KMNAME="kdebase-runtime"
KMNOMODULE=true
inherit kde4-meta

DESCRIPTION="KDE SC solid runtime modules (autoeject, automounter and others)"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

# Packages merged around 4.3.77
add_blocker solidautoeject
add_blocker solid-device-automounter
add_blocker solid-hardware
add_blocker soliduiserver
# Moved away from workspace
add_blocker solid '<4.5.69'

KMEXTRA="
	solid-device-automounter/
	solid-hardware/
	solid-networkstatus/
	solidautoeject/
	soliduiserver/
"
