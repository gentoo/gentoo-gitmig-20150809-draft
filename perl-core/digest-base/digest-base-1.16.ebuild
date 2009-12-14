# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/digest-base/digest-base-1.16.ebuild,v 1.7 2009/12/14 19:36:23 armin76 Exp $

EAPI=2

MY_PN=Digest
MY_P=${MY_PN}-${PV}
MODULE_AUTHOR=GAAS
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Modules that calculate message digests"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="virtual/perl-MIME-Base64"
DEPEND="${RDEPEND}"

SRC_TEST="do"
mydoc="rfc*.txt"
