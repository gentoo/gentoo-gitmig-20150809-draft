# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-tools/MIME-tools-5.411a-r2.ebuild,v 1.6 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P/a/}

DESCRIPTION="A Perl module for parsing and creating MIME entities"
SRC_URI="http://www.cpan.org/modules/by-module/MIME/ERYQ/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/MIME/ERYQ/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	>=dev-perl/IO-stringy-2.108
	dev-perl/MIME-Base64
	dev-perl/libnet
	dev-perl/URI
	dev-perl/Digest-MD5
	dev-perl/libwww-perl
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser
	dev-perl/MailTools"
