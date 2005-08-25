# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-CD-disc-cover/Audio-CD-disc-cover-0.05.ebuild,v 1.14 2005/08/25 22:24:03 agriffis Exp $

inherit perl-module

MY_P=Audio-CD-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl Module needed for app-cdr/disc-cover"
HOMEPAGE="http://homepages.inf.ed.ac.uk/jvanheme/disc-cover.html"
SRC_URI="http://homepages.inf.ed.ac.uk/jvanheme/files/${MY_P}.tar.gz"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"

DEPEND="${DEPEND}
	>=perl-core/MIME-Base64-2.12
	>=dev-perl/URI-1.10
	>=dev-perl/HTML-Parser-3.15
	>=perl-core/Digest-MD5-2.12
	>=dev-perl/libnet-1.0703-r1
	>=dev-perl/libwww-perl-5.50
	>=media-libs/libcdaudio-0.99.6"
