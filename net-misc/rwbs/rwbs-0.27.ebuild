# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rwbs/rwbs-0.27.ebuild,v 1.7 2004/07/15 03:29:01 agriffis Exp $

DESCRIPTION="Roger Wilco base station"
HOMEPAGE="http://rogerwilco.gamespy.com/"
SRC_URI="http://games.gci.net/pub/VoiceOverIP/RogerWilco/rwbs_Linux_0_27.tar.gz"

LICENSE="Resounding"
KEYWORDS="x86"
IUSE=""
SLOT="0"

# Everything is statically linked
DEPEND=""

S=${WORKDIR}

src_install() {
	dodoc README.TXT CHANGES.TXT
	rm -f {README,CHANGES,LICENSE}.TXT

	dobin rwbs run_rwbs
	rm -f rwbs run_rwbs

	# Put distribution into /usr/share/rwbs
	dodir /usr/share/rwbs/
	mv * ${D}/usr/share/rwbs/

	# Do conf script
	insinto /etc/conf.d
	newins ${FILESDIR}/rwbs.conf rwbs

	# do init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/rwbs.rc rwbs
}
