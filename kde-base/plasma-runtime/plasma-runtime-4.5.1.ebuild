# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-runtime/plasma-runtime-4.5.1.ebuild,v 1.1 2010/09/06 01:56:42 tampakrap Exp $

EAPI="3"

KMNAME="kdebase-runtime"
KMMODULE="plasma"
inherit kde4-meta

DESCRIPTION="Script engine and package tool for plasma"
KEYWORDS=""
IUSE="debug"

# cloned from workspace thus introduce collisions.
add_blocker plasma-workspace '<4.2.90'
