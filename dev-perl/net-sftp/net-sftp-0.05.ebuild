# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-sftp/net-sftp-0.05.ebuild,v 1.2 2004/02/22 20:47:04 agriffis Exp $

inherit perl-module

MY_P=Net-SFTP-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Secure File Transfer Protocol client"
SRC_URI="http://www.cpan.org/modules/by-authors/id/B/BT/BTROTT/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/B/BT/BTROTT/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~hppa ~mips ~ppc ~sparc"

DEPEND="dev-perl/net-ssh-perl"

