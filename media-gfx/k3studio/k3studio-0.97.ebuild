# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/k3studio/k3studio-0.97.ebuild,v 1.1 2002/01/25 17:02:58 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.1

newdepend ">=dev-lang/python-2.1
	   >=media-libs/glut-3.7
	   >=sys-libs/readline-4.1
	   >=media-libs/freetype-2.0.5"

DESCRIPTION="KDE universal workbench for 2D/3D modeling, visualization and simulation."
SRC_URI="http://prdownloads.sourceforge.net/k3studio/k3studio-0.97.tar.gz"
HOMEPAGE="http://k3studio.sourceforge.net"

