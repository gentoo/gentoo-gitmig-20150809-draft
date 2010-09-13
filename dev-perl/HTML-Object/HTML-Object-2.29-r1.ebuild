# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Object/HTML-Object-2.29-r1.ebuild,v 1.3 2010/09/13 13:15:34 josejx Exp $

EAPI=2

inherit perl-module

MY_P=libhtmlobject-perl-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="mirror://sourceforge/htmlobject/${MY_P}.tar.gz"
HOMEPAGE="http://htmlobject.sourceforge.net"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Data-FormValidator"
DEPEND="${RDEPEND}"
