# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-ldap/perl-ldap-0.25.ebuild,v 1.4 2003/02/13 11:28:18 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A collection of perl modules which provide an object-oriented interface to LDAP servers."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://perl-ldap.sourceforge.net"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 alpha"

DEPEND="${DEPEND}"
