# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/chessbrain/chessbrain-20407.ebuild,v 1.1 2003/12/10 15:31:07 phosphan Exp $

MY_PV=${PV}-01
DESCRIPTION="client for the ChessBrain distributed computing project"
HOMEPAGE="http://www.chessbrain.net/"
SRC_URI="http://www.chessbrain.net/client${MY_PV}-lin.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}

DEPEND=""
RDEPEND="
	sys-fs/e2fsprogs
	sys-libs/lib-compat"

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I=/opt/chessbrain

src_install() {
	exeinto /etc/init.d
	newexe ${FILESDIR}/cb-init.d chessbrain
	insinto /etc/conf.d
	newins ${FILESDIR}/cb-conf.d chessbrain
	echo "CHESSBRAIN_DIR=${I}">> ${D}/etc/conf.d/chessbrain

	insinto ${I}
	insopts "-m0644 -o nobody -g nogroup"
	doins cbspn.conf
	exeinto ${I}
	exeopts "-m 4755 -o nobody -g nogroup"
	doexe cbspn
}

pkg_postinst() {
	einfo "To run ChessBrain in the background at boot:"
	einfo " Edit ${I}/cbspn.conf for information relevant to ChessBrain"
	einfo "  See http://www.chessbrain.net/peernodenotes.html"
	einfo " Then just run \`/etc/init.d/chessbrain start\`"
	einfo
	einfo "Otherwise remember to cd into the directory"
	einfo "where it should keep its data files first, like so:"
	einfo " cd ${I} && ./cbspn"
}
