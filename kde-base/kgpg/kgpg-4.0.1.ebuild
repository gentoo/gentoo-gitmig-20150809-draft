# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgpg/kgpg-4.0.1.ebuild,v 1.3 2008/03/04 01:55:07 jer Exp $

EAPI="1"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug htmlhandbook"

RDEPEND="app-crypt/gnupg"
