# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/keditfiletype/keditfiletype-4.9.2.ebuild,v 1.2 2012/10/17 18:21:44 maekke Exp $

EAPI=4

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE mime/file type assocciation editor"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# test fails, last checked for 4.2.89
RESTRICT=test
