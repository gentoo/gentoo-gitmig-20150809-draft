# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/chessbrain/chessbrain-20314.ebuild,v 1.2 2003/04/23 14:34:35 vapier Exp $

MY_PV=${PV}-03
DESCRIPTION="distibuted computing project client"
HOMEPAGE="http://www.chessbrain.net/"
SRC_URI="http://www.chessbrain.net/client${MY_PV}-lin.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I=/opt/chessbrain

src_install() {
	dodir ${I}
	cp {cbspn,cbspn.conf} ${D}/${I}
	chown nobody.nogroup ${D}/${I}
	chown nobody.nogroup ${D}/${I}/cbspn
	chmod +s ${S}/cbspn

	exeinto /etc/init.d ; newexe ${FILESDIR}/cb-init.d chessbrain
	insinto /etc/conf.d ; newins ${FILESDIR}/cb-conf.d chessbrain
	echo "CHESSBRAIN_DIR=${I}">> ${D}/etc/conf.d/chessbrain
}

pkg_postinst() {
	einfo "To run ChessBrain in the background at boot:"
	einfo " Edit ${I}/cbspn.conf for information relevant to ChessBrain"
	einfo "  See http://www.chessbrain.net/peernodenotes.html"
	einfo " Then just run \`/etc/init.d/chessbrain start\`"
	einfo ""
	einfo "Otherwise remember to cd into the directory"
	einfo "where it should keep its data files first, like so:"
	einfo " cd ${I} && ./cbspn"
}
