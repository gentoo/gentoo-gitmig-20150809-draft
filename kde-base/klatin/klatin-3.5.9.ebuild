# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klatin/klatin-3.5.9.ebuild,v 1.5 2008/05/13 03:45:52 jer Exp $
KMNAME=kdeedu
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE: KLatin - a program to help revise Latin"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeducore"
KMCOPYLIB="libkdeeducore libkdeedu/kdeeducore"
