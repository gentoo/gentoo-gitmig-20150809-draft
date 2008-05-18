# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdenetwork/libkdenetwork-3.5.9.ebuild,v 1.7 2008/05/18 14:39:50 maekke Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="library common to many KDE network apps"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=app-crypt/gpgme-1.0.2"
RDEPEND="${DEPEND}"
