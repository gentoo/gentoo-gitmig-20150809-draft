# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-vfs-httpcaptive/gnome-vfs-httpcaptive-2.3.8.ebuild,v 1.1 2004/12/02 19:42:21 genstef Exp $

inherit gnome2

S=${WORKDIR}/${P}captive2

IUSE=""
DESCRIPTION="GNOME Virtual File System module for captive NTFS"
HOMEPAGE="http://www.jankratochvil.net/project/captive"
SRC_URI="http://www.jankratochvil.net/project/captive/dist/${P}captive2.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND="=gnome-base/gnome-vfs-2.6*"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"
