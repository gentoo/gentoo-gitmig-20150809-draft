# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speechd/speechd-0.56-r2.ebuild,v 1.3 2006/10/21 09:34:51 dertobi123 Exp $

inherit eutils

DESCRIPTION="Implements /dev/speech (any text written to /dev/speech will be spoken aloud)"
HOMEPAGE="http://www.speechio.org/"
SRC_URI="http://www.speechio.org/dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc ~x86"
IUSE="esd"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	esd? ( media-sound/esound )
	>=app-accessibility/festival-1.4.3-r1"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-catspeech-eof.patch
}

src_install() {
	dobin ${S}/bin/speechd ${S}/bin/catspeech
	use esd && dosed 's,#\($use_esd\),\1,g' /usr/bin/speechd
	insinto /etc
	doins  speechd.sub speechdrc
	exeinto /etc/init.d
	newexe ${FILESDIR}/speechd.rc speechd
	doman ${S}/man/man1/*.1
	dodoc README AUTHORS CHANGELOG TODO speechio.faq
}

pkg_postinst() {
	enewgroup speech
}
