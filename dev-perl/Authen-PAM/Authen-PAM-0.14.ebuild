# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-PAM/Authen-PAM-0.14.ebuild,v 1.10 2004/09/13 09:59:12 gmsoft Exp $

inherit perl-module

DESCRIPTION="Interface to PAM library"
HOMEPAGE="http://www.cs.kuleuven.ac.be/~pelov/pam/"
SRC_URI="http://www.cs.kuleuven.ac.be/~pelov/pam/download/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ia64 s390 ppc64 hppa"
IUSE=""

DEPEND="sys-libs/pam"

export OPTIMIZE="$CFLAGS"
