# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-sftp/net-sftp-0.08.ebuild,v 1.1 2004/03/29 12:27:56 mcummings Exp $

inherit perl-module

MY_P=Net-SFTP-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Secure File Transfer Protocol client"
HOMEPAGE="http://search.cpan.org/~drolsky/${MY_P}"
SRC_URI="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha"

DEPEND=">=dev-perl/net-ssh-perl-1.25"
