# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccounts-plugin/kdeaccounts-plugin-4.6.3.ebuild,v 1.2 2011/06/08 23:06:57 tomka Exp $

EAPI=4

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Addressbook Plugin that puts names/email addresses of all KDE SVN accounts into an addressbook"
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"
