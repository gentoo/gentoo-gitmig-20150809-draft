# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-PcapUtils/Net-PcapUtils-0.10.0.ebuild,v 1.1 2011/08/29 11:45:17 tove Exp $

EAPI=4

MODULE_AUTHOR=TIMPOTTER
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Perl Net::PcapUtils - Net::Pcap library utils"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Net-Pcap"
DEPEND="${RDEPEND}"
