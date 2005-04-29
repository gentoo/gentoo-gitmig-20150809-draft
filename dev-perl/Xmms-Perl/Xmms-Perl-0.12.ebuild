# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Xmms-Perl/Xmms-Perl-0.12.ebuild,v 1.10 2005/04/29 16:11:13 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="A Perl extension interface to XMMS"
HOMEPAGE="http://www.cpan.org/modules/by-module/Xmms/${P}.readme"
SRC_URI="mirror://cpan/authors/id/D/DO/DOUGM/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE=""

DEPEND="media-sound/xmms
	dev-perl/MP3-Info
	dev-perl/Term-ReadLine-Perl"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	# MPEG::MP3Info was renamed to MP3::Info
	epatch ${FILESDIR}/Xmms-Perl-0.12-MP3Info.diff
}
