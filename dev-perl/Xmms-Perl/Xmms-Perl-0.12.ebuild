# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Xmms-Perl/Xmms-Perl-0.12.ebuild,v 1.3 2003/09/06 22:37:58 msterret Exp $

inherit perl-module eutils

DESCRIPTION="A Perl extension interface to XMMS"
HOMEPAGE="http://www.cpan.org/modules/by-module/Xmms/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Xmms/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="media-sound/xmms
	dev-perl/MP3-Info
	dev-perl/Term-ReadLine-Perl"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	# MPEG::MP3Info was renamed to MP3::Info
	epatch ${FILESDIR}/Xmms-Perl-0.12-MP3Info.diff
}
