# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-tools/MIME-tools-6.20002.ebuild,v 1.1 2004/06/06 15:46:00 mcummings Exp $

inherit perl-module

MY_PV=${PV/000/00_0}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Perl module for parsing and creating MIME entities"
SRC_URI="http://www.cpan.org/modules/by-module/MIME/ERYQ/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/MIME/ERYQ/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	>=dev-perl/IO-stringy-2.108
	dev-perl/MIME-Base64
	dev-perl/libnet
	dev-perl/URI
	dev-perl/Digest-MD5
	dev-perl/libwww-perl
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser
	dev-perl/Unicode-String
	dev-perl/Unicode-Map
	dev-perl/MailTools"
