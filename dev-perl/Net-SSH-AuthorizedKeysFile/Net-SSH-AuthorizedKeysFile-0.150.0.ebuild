# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSH-AuthorizedKeysFile/Net-SSH-AuthorizedKeysFile-0.150.0.ebuild,v 1.1 2011/08/29 11:32:42 tove Exp $

EAPI=4

MODULE_AUTHOR=MSCHILLI
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="Read and modify ssh's authorized_keys files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Log-Log4perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
