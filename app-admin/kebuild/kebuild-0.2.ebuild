# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/kebuild/kebuild-0.2.ebuild,v 1.1 2002/04/17 18:53:05 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3
DESCRIPTION="Graphical KDE emerge tool"
SRC_URI="http://prdownloads.sourceforge.net/kemerge/${P}.tar.gz"
HOMEPAGE="http://kemerge.sourceforge.net/"
newdepend ">=app-admin/kebuildpart-0.2"
