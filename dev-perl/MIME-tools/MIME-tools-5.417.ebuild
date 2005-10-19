# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-tools/MIME-tools-5.417.ebuild,v 1.7 2005/10/19 17:30:59 killerfox Exp $

inherit perl-module

DESCRIPTION="A Perl module for parsing and creating MIME entities"
SRC_URI="mirror://cpan/authors/id/D/DS/DSKOLL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dskoll/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/IO-stringy-2.108
	>=perl-core/MIME-Base64-3.05
	dev-perl/libnet
	dev-perl/URI
	perl-core/Digest-MD5
	dev-perl/libwww-perl
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser
	dev-perl/MailTools"
