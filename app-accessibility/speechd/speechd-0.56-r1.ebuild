# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speechd/speechd-0.56-r1.ebuild,v 1.8 2004/07/22 11:35:25 eradicator Exp $

inherit eutils

DESCRIPTION="Implements /dev/speech (any text written to /dev/speech will be spoken aloud)"
HOMEPAGE="http://www.speechio.org/"
SRC_URI="http://www.speechio.org/dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 ~sparc"
IUSE="esd"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	esd? ( media-sound/esound )
	>=app-accessibility/festival-1.4.3-r1"

S=${WORKDIR}/${PN}

src_compile() {
	emake || die
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

	mkfifo --mode=0660 /dev/speech
	chown root:speech /dev/speech
}

# This would get executed on an upgrade...
#pkg_postrm () {
#	einfo "Removing FIFO at /dev/speech ..."
#	rm -f /dev/speech
#}
