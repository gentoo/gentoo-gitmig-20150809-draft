# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-PAM/Authen-PAM-0.12-r3.ebuild,v 1.4 2003/02/13 10:56:57 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD:mysql Module"
SRC_URI="http://www.cs.kuleuven.ac.be/~pelov/pam/download/${P}.tar.gz"
HOMEPAGE="http://www.cs.kuleuven.ac.be/~pelov/pam/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	sys-libs/pam"


export OPTIMIZE="$CFLAGS"
