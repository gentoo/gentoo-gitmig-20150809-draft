# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlrapi/perlrapi-0.2.ebuild,v 1.3 2003/06/21 21:36:44 drobbins Exp $

inherit perl-module 

IUSE=""

S=${WORKDIR}/perlrapi

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync. - PERL bindings" 
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/glibc
	app-pda/synce-librapi2"

