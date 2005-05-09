# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/frontier-rpc/frontier-rpc-0.07_beta4.ebuild,v 1.9 2005/05/09 15:14:31 dholm Exp $

inherit perl-module

MY_P=Frontier-RPC-0.07b4
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Perl 5 module for performing remote procedure calls
using extensible markup language"
SRC_URI="http://perl-xml.sourceforge.net/xml-rpc/${MY_P}.tar.gz"
HOMEPAGE="http://perl-xml.sourceforge.net/xml-rpc/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="dev-perl/XML-Parser
		dev-perl/libwww-perl"
