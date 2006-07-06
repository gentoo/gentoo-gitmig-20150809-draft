# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lastfm-ripper/lastfm-ripper-1.2.1.ebuild,v 1.2 2006/07/06 07:59:21 blubb Exp $

inherit perl-module eutils

DESCRIPTION="save last.fm radio to mp3 files"
HOMEPAGE="http://search.cpan.org/src/JOCHEN/last.fm-ripper-1.2/README"
SRC_URI="mirror://cpan/authors/id/J/JO/JOCHEN/last.fm-ripper-${PV}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="amazon tagwriting minimal"

DEPEND="perl-core/Getopt-Long
	perl-core/Digest-MD5
	!minimal? ( dev-perl/Term-ReadPassword )
	tagwriting? ( dev-perl/MP3-Tag )
	amazon? ( dev-perl/MP3-Tag dev-perl/Net-Amazon )"

S="${WORKDIR}/last.fm-ripper-${PV}"
src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/UnescapedVariableFix.patch
	epatch ${FILESDIR}/CoverOutputDirectoryFix.patch
}
