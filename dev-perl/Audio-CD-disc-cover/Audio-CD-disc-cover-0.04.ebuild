# Copyright 2002 Gentoo Technologies Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-CD-disc-cover/Audio-CD-disc-cover-0.04.ebuild,v 1.4 2002/07/31 04:23:35 cselkirk Exp $

inherit perl-module

MY_P=Audio-CD-0.04-disc-cover-1.1.0
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl Module needed for app-cdr/disc-cover"
HOMEPAGE="http://www.liacs.nl/~jvhemert/disc-cover"
SRC_URI="http://www.liacs.nl/~jvhemert/disc-cover/download/libraries/${MY_P}.tar.gz"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"

DEPEND="${DEPEND}
	>=dev-perl/MIME-Base64-2.12
	>=dev-perl/URI-1.10
	>=dev-perl/HTML-Parser-3.15
	>=dev-perl/Digest-MD5-2.12
	>=dev-perl/libnet-1.0703-r1
	>=dev-perl/libwww-perl-5.50
	>=media-libs/libcdaudio-0.99.6"  

RDEPEND="${DEPEND}"
