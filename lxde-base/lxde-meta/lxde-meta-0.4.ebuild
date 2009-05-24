# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxde-meta/lxde-meta-0.4.ebuild,v 1.1 2009/05/24 23:18:28 yngwin Exp $

DESCRIPTION="Meta ebuild for LXDE, the Lightweight X11 Desktop Environment"
HOMEPAGE="http://lxde.sf.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=lxde-base/lxappearance-0.2*
	=lxde-base/lxde-common-0.4*
	=lxde-base/lxpanel-0.4*
	~lxde-base/lxrandr-0.1
	~lxde-base/lxsession-0.3.8
	~lxde-base/lxtask-0.1
	lxde-base/lxterminal
	media-gfx/gpicview
	x11-misc/pcmanfm
	x11-wm/openbox
	x11-misc/obconf"
