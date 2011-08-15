# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konsole/konsole-4.6.5.ebuild,v 1.3 2011/08/15 20:03:32 maekke Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"

if [[ ${PV} = *9999 ]]; then
	kde_eclass="kde4-base"
else
	KMNAME="kdebase-apps"
	kde_eclass="kde4-meta"
fi
inherit ${kde_eclass}

DESCRIPTION="X terminal for use with KDE."
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

COMMONDEPEND="
	!aqua? (
		x11-libs/libX11
		x11-libs/libXext
		>=x11-libs/libxklavier-3.2
		x11-libs/libXrender
		x11-libs/libXtst
	)
"
DEPEND="${COMMONDEPEND}
	!aqua? (
		x11-apps/bdftopcf
		x11-proto/kbproto
		x11-proto/renderproto
	)
"
RDEPEND="${COMMONDEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.6.4-imagesize.patch" )
