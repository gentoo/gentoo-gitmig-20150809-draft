# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-ldap/perl-ldap-0.25.ebuild,v 1.5 2003/06/21 21:36:44 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A collection of perl modules which provide an object-oriented interface to LDAP servers."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://perl-ldap.sourceforge.net"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 alpha"

DEPEND="${DEPEND}"
