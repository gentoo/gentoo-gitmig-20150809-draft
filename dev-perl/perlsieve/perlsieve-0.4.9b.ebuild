# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlsieve/perlsieve-0.4.9b.ebuild,v 1.9 2004/10/16 23:57:25 rac Exp $

inherit perl-module

S=${WORKDIR}/perlsieve-0.4.9
DESCRIPTION="Access Sieve services"
HOMEPAGE="http://sourceforge.net/projects/websieve/"
SRC_URI="http://lists.opensoftwareservices.com/websieve/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~amd64 alpha ~hppa ~mips ~ppc ~sparc s390"
IUSE=""
