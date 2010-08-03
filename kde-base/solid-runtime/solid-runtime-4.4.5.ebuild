# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solid-runtime/solid-runtime-4.4.5.ebuild,v 1.3 2010/08/03 07:42:30 hwoarang Exp $

EAPI="3"

KMNAME="kdebase-runtime"
KMNOMODULE=true
inherit kde4-meta

DESCRIPTION="KDE SC solid runtime modules (autoeject, automounter and others)"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

# Packages merged around 4.3.77
add_blocker solidautoeject
add_blocker solid-device-automounter
add_blocker solid-hardware
add_blocker soliduiserver

KMEXTRA="
	solidautoeject/
	solid-device-automounter/
	solid-hardware/
	soliduiserver/
"
