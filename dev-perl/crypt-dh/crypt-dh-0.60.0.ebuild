# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-dh/crypt-dh-0.60.0.ebuild,v 1.2 2011/09/03 21:04:52 tove Exp $

EAPI=4

MY_PN=Crypt-DH
MODULE_AUTHOR=BTROTT
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Diffie-Hellman key exchange system"

SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/math-pari
	>=virtual/perl-Math-BigInt-1.60
	dev-perl/crypt-random"
DEPEND="${RDEPEND}"
