# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR/PEAR-PEAR-1.3.5.ebuild,v 1.9 2005/03/19 22:47:17 weeve Exp $

inherit php-pear

DESCRIPTION="PEAR Base System."
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 amd64 ppc64 ppc ia64 sparc ~alpha ~hppa"
IUSE=""
RDEPEND=">=dev-php/PEAR-Archive_Tar-1.1
		>=dev-php/PEAR-Console_Getopt-1.2
		>=dev-php/PEAR-XML_RPC-1.0.4"
