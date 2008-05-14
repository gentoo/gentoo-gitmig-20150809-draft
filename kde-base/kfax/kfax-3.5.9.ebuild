# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfax/kfax-3.5.9.ebuild,v 1.6 2008/05/14 18:14:46 corsair Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE G3/G4 fax viewer"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/kviewshell-${PV}:${SLOT}"

KMEXTRA="kfaxview"
KMCOPYLIB="libkmultipage kviewshell"
KMEXTRACTONLY="kviewshell/"
KMCOMPILEONLY="kviewshell"
