# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc/mhonarc-2.6.8-r1.ebuild,v 1.2 2004/06/24 23:25:45 agriffis Exp $

IUSE=""

inherit perl-module
CATEGORY="net-mail"

MY_P="${P/mhonarc/MHonArc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Perl Mail-to-HTML Converter"
SRC_URI="http://www.cpan.org/modules/by-authors/id/EHOOD/${MY_P}.tar.gz"
HOMEPAGE="http:/search.cpan.org/author/EHOOD/${MY_P}/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha mips ~amd64"

src_install() {
	perl-module_src_install
}
