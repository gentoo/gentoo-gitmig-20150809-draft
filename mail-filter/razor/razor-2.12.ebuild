# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/razor/razor-2.12.ebuild,v 1.1 2004/06/03 07:28:42 seemant Exp $

inherit perl-module

S="${WORKDIR}/razor-agents-${PV}"

DESCRIPTION="Vipul's Razor is a distributed, collaborative spam detection and filtering network"
HOMEPAGE="http://razor.sourceforge.net"
SRC_URI="mirror://sourceforge/razor/razor-agents-${PV}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc"

RDEPEND="dev-lang/perl
	dev-perl/Net-DNS
	dev-perl/Time-HiRes
	dev-perl/Digest-SHA1
	dev-perl/URI
	dev-perl/Digest-Nilsimsa"
