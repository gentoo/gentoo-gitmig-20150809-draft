# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdenetwork/libkdenetwork-3.5.10-r1.ebuild,v 1.8 2009/08/25 14:57:54 jer Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="library common to many KDE network apps"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=app-crypt/gpgme-1.0.2"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-gpgme-1.2.0.patch" )
