# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPC-XML/RPC-XML-0.40.ebuild,v 1.1 2002/05/20 10:19:50 seemant Exp $

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A  Perl extension interface to James Clark's XML parser, expat."
SRC_URI="http://cpan.valueclick.com/modules/by-module/RPC/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/RPC/${PN}.${PV}.readme"

DEPEND="${DEPEND} dev-perl/XML-Parser dev-perl/mod_perl"
