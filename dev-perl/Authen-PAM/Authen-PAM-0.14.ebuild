# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-PAM/Authen-PAM-0.14.ebuild,v 1.6 2004/04/18 02:14:13 randy Exp $

inherit perl-module

DESCRIPTION="Interface to PAM library"
HOMEPAGE="http://www.cs.kuleuven.ac.be/~pelov/pam/"
SRC_URI="http://www.cs.kuleuven.ac.be/~pelov/pam/download/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ia64 s390"

DEPEND="sys-libs/pam"

export OPTIMIZE="$CFLAGS"
