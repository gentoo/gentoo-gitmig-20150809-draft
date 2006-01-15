# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Sender/Mail-Sender-0.8.10.ebuild,v 1.2 2006/01/15 17:39:48 mcummings Exp $

inherit perl-module

DESCRIPTION="Module for sending mails with attachments through an SMTP server"
HOMEPAGE="http://search.cpan.org/~jenda/Mail-Sender-0.8.10"
SRC_URI="mirror://cpan/authors/id/J/JE/JENDA/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="perl-core/MIME-Base64"
RDEPEND=""

src_compile() {
	echo "n" | perl-module_src_compile
}
