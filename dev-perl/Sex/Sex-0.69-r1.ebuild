# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sex/Sex-0.69-r1.ebuild,v 1.1 2002/10/30 07:20:40 seemant Exp $

inherit perl-module

S="${WORKDIR}"
DESCRIPTION="Sex - Perl teaches the birds and the bees: Heterogeneous recombination of Perl packages"
SRC_URI="http://www.activestate.com/PPMPackages/5.6plus/i686-linux-thread-multi/Sex.tar.gz"
HOMEPAGE="http://aspn.activestate.com/ASPN/CodeDoc/Sex/Sex.html"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 -ppc -sparc -sparc64 -alpha"

src_compile() {
	einfo "Installing Sex into ${ARCH_LIB}"
}

src_install() {
	dohtml `find ${S} -name Sex.html`
	doman `find ${S} -name Sex.3`
#	dodir ${ARCH_LIB}
	insinto ${ARCH_LIB}
	newins `find ${S} -name Sex.pm` Sex.pm
}
