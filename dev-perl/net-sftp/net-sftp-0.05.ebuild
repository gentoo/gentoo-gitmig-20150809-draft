# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-sftp/net-sftp-0.05.ebuild,v 1.3 2004/02/22 23:38:12 vapier Exp $

inherit perl-module

MY_P=Net-SFTP-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Secure File Transfer Protocol client"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/B/BT/BTROTT/${MY_P}.readme"
SRC_URI="http://www.cpan.org/modules/by-authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha"

DEPEND="dev-perl/net-ssh-perl"
