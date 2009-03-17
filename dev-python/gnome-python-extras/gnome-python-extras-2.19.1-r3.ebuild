# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python-extras/gnome-python-extras-2.19.1-r3.ebuild,v 1.6 2009/03/17 17:52:26 armin76 Exp $

DESCRIPTION="Meta build which provides python interfacing modules for some GNOME libraries"
HOMEPAGE="http://pygtk.org/"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="=dev-python/egg-python-${PV}*
	=dev-python/gdl-python-${PV}*
	=dev-python/gtkhtml-python-${PV}*
	=dev-python/gtkmozembed-python-${PV}*
	=dev-python/gtkspell-python-${PV}*
	=dev-python/libgksu-python-${PV}*
	=dev-python/libgda-python-${PV}*"
