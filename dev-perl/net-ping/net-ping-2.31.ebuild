# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-ping/net-ping-2.31.ebuild,v 1.2 2003/12/30 18:42:23 mcummings Exp $

inherit perl-module

MY_P=Net-Ping-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="check a remote host for reachability"
SRC_URI="http://search.cpan.org/CPAN/authors/id/B/BB/BBB/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/BBB/${MY_P}/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha ~hppa"

DEPEND="${DEPEND}"
