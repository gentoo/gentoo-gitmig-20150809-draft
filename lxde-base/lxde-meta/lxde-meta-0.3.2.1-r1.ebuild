# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxde-meta/lxde-meta-0.3.2.1-r1.ebuild,v 1.1 2009/01/05 20:56:59 yngwin Exp $

DESCRIPTION="Meta ebuild for LXDE, the Lightweight X11 Desktop Environment"
HOMEPAGE="http://lxde.sf.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="~lxde-base/lxappearance-0.2
	~lxde-base/lxde-common-0.3.2.1
	~lxde-base/lxlauncher-0.2
	~lxde-base/lxpanel-0.3.8.1
	~lxde-base/lxrandr-0.1
	~lxde-base/lxsession-lite-0.3.6
	~lxde-base/lxtask-0.1
	~lxde-base/lxterminal-0.1.3
	media-gfx/gpicview
	x11-misc/pcmanfm
	x11-wm/openbox
	x11-misc/obconf"
