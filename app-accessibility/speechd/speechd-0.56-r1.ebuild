# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speechd/speechd-0.56-r1.ebuild,v 1.1 2004/03/17 03:40:52 eradicator Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Implements /dev/speech (any text written to /dev/speech will be spoken aloud)"
HOMEPAGE="http://www.speechio.org/"
SRC_URI="http://www.speechio.org/dl/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="esd"

DEPEND="dev-lang/perl"

RDEPEND="${DEPEND}
	esd? ( media-sound/esound )
	>=media-sound/festival-1.4.3-r1"

src_compile() {
	emake || die
}

src_install () {
	dobin ${S}/bin/speechd ${S}/bin/catspeech
	use esd && dosed 's,#\($use_esd\),\1,g' /usr/bin/speechd
	insinto /etc
	doins  speechd.sub speechdrc
	exeinto /etc/init.d
	newexe ${FILESDIR}/speechd.rc speechd
	doman ${S}/man/man1/*.1
	dodoc README AUTHORS CHANGELOG COPYING TODO speechio.faq
}

pkg_postinst () {
	enewgroup speech

	einfo "Execute ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to build the neccessary FIFO on /dev/speech."
}

pkg_config () {
	mkfifo --mode=0660 /dev/speech
	chown root:speech /dev/speech

	einfo "FIFO has been created on /dev/speech"
	einfo ""
	einfo "In order for non-root users to take advantage of /dev/speech"
	einfo "they must be added to the 'speech' group."
}

# This would get executed on an upgrade...
#pkg_postrm () {
#	einfo "Removing FIFO at /dev/speech ..."
#	rm -f /dev/speech
#}
