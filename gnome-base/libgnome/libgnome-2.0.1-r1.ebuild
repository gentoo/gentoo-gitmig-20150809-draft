# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnome/libgnome-2.0.1-r1.ebuild,v 1.3 2002/07/19 13:07:56 stroke Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Essential Gnome Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=dev-libs/libxslt-1.0.18
	>=dev-libs/glib-2.0.0
	>=gnome-base/gconf-1.1.11
	>=gnome-base/gnome-mime-data-1.0.7
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/gnome-vfs-1.9.16
	>=media-sound/esound-0.2.25
	>=media-libs/audiofile-0.2.3
	>=dev-libs/libxml2-2.4.22
	>=sys-apps/gawk-3.1.0
	>=sys-devel/perl-5.6.1-r3"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	doc? ( >=dev-util/gtk-doc-0.9 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING*  ChangeLog INSTALL NEWS README"

SCHEMAS="desktop_gnome_accessibility_keyboard.schemas 
	desktop_gnome_applications_browser.schemas  
	desktop_gnome_applications_editor.schemas 
	desktop_gnome_applications_help_viewer.schemas  
	desktop_gnome_applications_terminal.schemas 
	desktop_gnome_applications_window_manager.schemas 
	desktop_gnome_background.schemas 
	desktop_gnome_file_views.schemas 
	desktop_gnome_interface.schemas
	desktop_gnome_peripherals_keyboard.schemas
	desktop_gnome_peripherals_mouse.schemas
	desktop_gnome_sound.schemas
	desktop_gnome_url_handlers.schemas"
	
