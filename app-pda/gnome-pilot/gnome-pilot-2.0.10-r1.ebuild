# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot/gnome-pilot-2.0.10-r1.ebuild,v 1.6 2004/02/15 11:41:39 liquidx Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Pilot apps"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc"

RDEPEND=">=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libglade-2.0.0
	>=gnome-base/ORBit2-2.6.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/gnome-panel-2.0
	>=gnome-base/gconf-2.0
	>=dev-util/gob-2.0.5
	>=app-pda/pilot-link-0.11.7"

DEPEND="sys-devel/gettext
		>=dev-lang/perl-5.6.0
		${RDEPEND}"

G2CONF="${G2CONF} --enable-usb --enable-network --enable-pilotlinktest"

DOCS="AUTHORS COPYING* ChangeLog README NEWS"
SCROLLKEEPER_UPDATE="0"

src_unpack() {
	unpack  ${A}
	# patch to fix crashes with memo file syncing
	# http://bugzilla.gnome.org/show_bug.cgi?id=114361
	epatch ${FILESDIR}/${P}-memofile.patch
	# add treo600 support
	# http://bugzilla.gnome.org/show_bug.cgi?id=124254
	epatch ${FILESDIR}/${P}-treo600.patch
}
