# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/psi-themes/psi-themes-0.9.1.ebuild,v 1.3 2004/03/29 00:05:47 weeve Exp $

SMILEYS="http://dev.gentoo.org/~humpback/jisp/AIM.jisp
	http://dev.gentoo.org/~humpback/jisp/apple_ichat-1.0.jisp
	http://dev.gentoo.org/~humpback/jisp/critters-1.0.jisp
	http://dev.gentoo.org/~humpback/jisp/gadu-gadu.jisp
	http://dev.gentoo.org/~humpback/jisp/JIM.jisp
	http://dev.gentoo.org/~humpback/jisp/KMess-Cartoon-1.0.jisp
	http://dev.gentoo.org/~humpback/jisp/kreativ_squareheads.jisp
	http://dev.gentoo.org/~humpback/jisp/msn.jisp
	http://dev.gentoo.org/~humpback/jisp/patricks_faces-1.0.jisp
	http://dev.gentoo.org/~humpback/jisp/rhymbox-1.0.jisp
	http://dev.gentoo.org/~humpback/jisp/shinyicons.jisp
	http://dev.gentoo.org/~humpback/jisp/taryn.jisp
	http://dev.gentoo.org/~humpback/jisp/tlen.pl-3.73.jisp
	http://dev.gentoo.org/~humpback/jisp/trill-basic-smileys.jisp
	http://dev.gentoo.org/~humpback/jisp/trill-extra-smileys.jisp
	http://dev.gentoo.org/~humpback/jisp/trill-extra-symbols.jisp
	http://dev.gentoo.org/~humpback/jisp/trill-msn.jisp
	http://dev.gentoo.org/~humpback/jisp/trill-yahoo.jisp
	http://dev.gentoo.org/~humpback/jisp/yahoo_messenger.jisp
	"

ICONSETS="http://dev.gentoo.org/~humpback/jisp/amibulb.jisp
	http://dev.gentoo.org/~humpback/jisp/amiglobe.jisp
	http://dev.gentoo.org/~humpback/jisp/berlin.jisp
	http://dev.gentoo.org/~humpback/jisp/berlin-icq.jisp
	http://dev.gentoo.org/~humpback/jisp/chrome.jisp
	http://dev.gentoo.org/~humpback/jisp/dudes.jisp
	http://dev.gentoo.org/~humpback/jisp/dudes32.jisp
	http://dev.gentoo.org/~humpback/jisp/email.jisp
	http://dev.gentoo.org/~humpback/jisp/icqG.jisp
	http://dev.gentoo.org/~humpback/jisp/individual.jisp
	http://dev.gentoo.org/~humpback/jisp/kitty.jisp
	http://dev.gentoo.org/~humpback/jisp/neos.jisp
	http://dev.gentoo.org/~humpback/jisp/puyo.jisp
	http://dev.gentoo.org/~humpback/jisp/raro.jisp
	http://dev.gentoo.org/~humpback/jisp/rss.jisp
	http://dev.gentoo.org/~humpback/jisp/speechbubbles.jisp
	http://dev.gentoo.org/~humpback/jisp/squareheads.jisp
	http://dev.gentoo.org/~humpback/jisp/tlen.jisp
	http://dev.gentoo.org/~humpback/jisp/weather.jisp
	http://dev.gentoo.org/~humpback/jisp/wpk.jisp
	"

SRC_URI="${SMILEYS}${ICONSETS}"

DESCRIPTION="Iconsets for Psi, a QT 3.x Jabber Client"
HOMEPAGE="http://psi.affinix.com/ http://jisp.netflint.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

DEPEND=">=net-im/psi-0.9.1"

S=${WORKDIR}

src_unpack() {
	mkdir emoticons
	for FILE in ${SMILEYS}; do
		cp ${DISTDIR}/$(basename ${FILE}) emoticons
	done
	mkdir roster
	for FILE in ${ICONSETS}; do
		cp ${DISTDIR}/$(basename ${FILE}) roster
	done
}

src_install() {
	dodir /usr/share/psi/iconsets
	mv * ${D}/usr/share/psi/iconsets/
}

