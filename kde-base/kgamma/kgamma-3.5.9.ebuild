# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgamma/kgamma-3.5.9.ebuild,v 1.8 2008/06/30 00:29:41 carlo Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE screen gamma values kcontrol module"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-libs/libXxf86vm"