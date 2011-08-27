# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-random/crypt-random-1.250.0.ebuild,v 1.1 2011/08/27 20:02:59 tove Exp $

EAPI=4

MY_PN=Crypt-Random
MODULE_AUTHOR=VIPUL
MODULE_VERSION=1.25
inherit perl-module

DESCRIPTION="Cryptographically Secure, True Random Number Generator"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/math-pari-2.010603
	dev-perl/class-loader"
DEPEND="${RDEPEND}"

SRC_TEST="do"
