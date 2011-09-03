# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-PcapUtils/Net-PcapUtils-0.10.0.ebuild,v 1.2 2011/09/03 21:05:32 tove Exp $

EAPI=4

MODULE_AUTHOR=TIMPOTTER
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Perl Net::PcapUtils - Net::Pcap library utils"

SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/Net-Pcap"
DEPEND="${RDEPEND}"
