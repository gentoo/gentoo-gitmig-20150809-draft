# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-ldap/perl-ldap-0.25-r1.ebuild,v 1.1 2002/10/30 07:20:41 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A collection of perl modules which provide an object-oriented interface to LDAP servers."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://perl-ldap.sourceforge.net"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 alpha"

DEPEND="${DEPEND}"
