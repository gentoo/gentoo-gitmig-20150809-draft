# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-runtime/plasma-runtime-4.3.1.ebuild,v 1.5 2009/10/24 19:44:19 josejx Exp $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="plasma"
inherit kde4-meta

DESCRIPTION="Script engine and package tool for plasma"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 x86"
IUSE="debug"

# cloned from workspace thus introduce collisions.
RDEPEND="
	!kdeprefix? ( !<kde-base/plasma-workspace-4.2.90[-kdeprefix] )
	kdeprefix? (  !<kde-base/plasma-workspace-4.2.90:${SLOT}[kdeprefix] )
"
