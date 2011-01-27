# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxde-meta/lxde-meta-0.5.0-r5.ebuild,v 1.6 2011/01/27 10:06:29 hwoarang Exp $

DESCRIPTION="Meta ebuild for LXDE, the Lightweight X11 Desktop Environment"
HOMEPAGE="http://lxde.sf.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ppc x86"
IUSE=""

RDEPEND="=lxde-base/lxappearance-0.5*
	=lxde-base/lxde-icon-theme-0.0*
	=lxde-base/lxde-common-0.5.0-r1
	=lxde-base/lxmenu-data-0.1*
	=lxde-base/lxinput-0.3*
	=lxde-base/lxpanel-0.5.6*
	=lxde-base/lxrandr-0.1*
	>=lxde-base/lxsession-0.4.4
	=lxde-base/lxsession-edit-0.1*
	=lxde-base/lxshortcut-0.1*
	=lxde-base/lxtask-0.1*
	=lxde-base/lxterminal-0.1.9*
	media-gfx/gpicview
	x11-misc/pcmanfm
	x11-wm/openbox
	x11-misc/obconf"

pkg_postinst() {
	elog "For your convenience you can review the LXDE Configuration HOWTO at"
	elog "http://www.gentoo.org/proj/en/desktop/lxde/lxde-howto.xml"
}
