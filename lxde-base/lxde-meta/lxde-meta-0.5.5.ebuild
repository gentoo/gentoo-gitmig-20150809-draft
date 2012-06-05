# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxde-meta/lxde-meta-0.5.5.ebuild,v 1.7 2012/06/05 01:11:05 xmw Exp $

EAPI="2"

DESCRIPTION="Meta ebuild for LXDE, the Lightweight X11 Desktop Environment"
HOMEPAGE="http://lxde.sf.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ppc x86"
IUSE=""

RDEPEND="=lxde-base/lxappearance-0.5*
	=lxde-base/lxde-icon-theme-0.0*
	=lxde-base/lxde-common-0.5.5*
	=lxde-base/lxmenu-data-0.1*
	=lxde-base/lxinput-0.3*
	=lxde-base/lxpanel-0.5.8*
	=lxde-base/lxrandr-0.1*
	>=lxde-base/lxsession-0.4.6.1
	=lxde-base/lxsession-edit-0.2*
	=lxde-base/lxshortcut-0.1*
	=lxde-base/lxtask-0.1*
	=lxde-base/lxterminal-0.1.11*
	media-gfx/gpicview
	x11-misc/pcmanfm
	x11-wm/openbox
	|| ( <=x11-misc/obconf-2.0.3-r1 >x11-misc/obconf-2.0.3-r1[lxde]
	>=x11-misc/obconf-2.0.3_p20111019 )"

pkg_postinst() {
	elog "For your convenience you can review the LXDE Configuration HOWTO at"
	elog "http://www.gentoo.org/proj/en/desktop/lxde/lxde-howto.xml"
}
