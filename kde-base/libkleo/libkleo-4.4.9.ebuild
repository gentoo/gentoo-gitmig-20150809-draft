# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkleo/libkleo-4.4.9.ebuild,v 1.3 2011/01/28 19:51:04 tomka Exp $

EAPI="3"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE library for encryption handling."
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-crypt/gpgme
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

KMSAVELIBS="true"
KMEXTRACTONLY="kleopatra/"
