# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/speechd/speechd-0.56.ebuild,v 1.9 2004/02/19 04:02:22 augustus Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Implements /dev/speech (any text written to /dev/speech will be spoken aloud)"
HOMEPAGE="http://www.speechio.org/"
SRC_URI="http://www.speechio.org/dl/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="dev-lang/perl
	media-sound/festival"

src_compile() {
	emake || die
}

src_install () {
	dobin ${S}/bin/speechd ${S}/bin/catspeech
	insinto /etc
	doins speechdrc speechd.sub
	doman ${S}/man/man1/*.1
	dodoc README AUTHORS CHANGELOG COPYING TODO
}

pkg_postinst () {
	if ! grep -q ^speech: /etc/group ; then
		groupadd speech || die "problem adding group speech"
	fi

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

pkg_postrm () {
	einfo "Removing FIFO at /dev/speech ..."
	rm -f /dev/speech
}
