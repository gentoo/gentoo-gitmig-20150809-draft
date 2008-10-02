# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgpg/kgpg-4.1.2.ebuild,v 1.1 2008/10/02 08:40:45 jmbsvicetto Exp $

EAPI="2"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="app-crypt/gnupg"
