# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccounts-plugin/kdeaccounts-plugin-4.6.2.ebuild,v 1.4 2011/06/01 17:55:55 ranger Exp $

EAPI=3

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Addressbook Plugin that puts names/email addresses of all KDE SVN accounts into an addressbook"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"
