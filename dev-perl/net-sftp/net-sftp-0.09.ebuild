# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-sftp/net-sftp-0.09.ebuild,v 1.2 2006/03/31 20:27:17 mcummings Exp $

inherit perl-module

MY_P=Net-SFTP-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Secure File Transfer Protocol client"
HOMEPAGE="http://search.cpan.org/search?module=${PN}"
SRC_URI="mirror://cpan/authors/id/D/DB/DBROBINS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha"
IUSE=""

DEPEND=">=dev-perl/net-ssh-perl-1.25"
