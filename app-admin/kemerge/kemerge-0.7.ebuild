# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kemerge/kemerge-0.7.ebuild,v 1.7 2003/02/13 05:25:15 vapier Exp $
inherit kde-base

need-kde 3
DESCRIPTION="Graphical KDE emerge tool"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://kemerge.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 -ppc sparc " # ppc compilation error: see Changelog

IUSE=""
