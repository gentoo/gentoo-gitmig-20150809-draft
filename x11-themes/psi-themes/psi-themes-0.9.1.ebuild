# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/psi-themes/psi-themes-0.9.1.ebuild,v 1.1 2004/03/01 14:00:45 humpback Exp $

SMILEYS="http://jisp.netflint.net/smile/AIM.jisp
	http://jisp.netflint.net/smile/apple_ichat-1.0.jisp
	http://jisp.netflint.net/smile/critters-1.0.jisp
	http://jisp.netflint.net/smile/gadu-gadu.jisp
	http://jisp.netflint.net/smile/JIM.jisp
	http://jisp.netflint.net/smile/KMess-Cartoon-1.0.jisp
	http://jisp.netflint.net/smile/kreativ_squareheads.jisp
	http://jisp.netflint.net/smile/msn.jisp
	http://jisp.netflint.net/smile/patricks_faces-1.0.jisp
	http://jisp.netflint.net/smile/rhymbox-1.0.jisp
	http://jisp.netflint.net/smile/shinyicons.jisp
	http://jisp.netflint.net/smile/taryn.jisp
	http://jisp.netflint.net/smile/tlen.pl-3.73.jisp
	http://jisp.netflint.net/smile/trill-basic-smileys.jisp
	http://jisp.netflint.net/smile/trill-extra-smileys.jisp
	http://jisp.netflint.net/smile/trill-extra-symbols.jisp
	http://jisp.netflint.net/smile/trill-msn.jisp
	http://jisp.netflint.net/smile/trill-yahoo.jisp
	http://jisp.netflint.net/smile/yahoo_messenger.jisp
	"

ICONSETS="http://jisp.netflint.net/sets/amibulb.jisp
	http://jisp.netflint.net/sets/amiglobe.jisp
	http://jisp.netflint.net/sets/berlin.jisp
	http://jisp.netflint.net/sets/berlin-icq.jisp
	http://jisp.netflint.net/sets/chrome.jisp
	http://jisp.netflint.net/sets/dudes.jisp
	http://jisp.netflint.net/sets/dudes32.jisp
	http://jisp.netflint.net/sets/email.jisp
	http://jisp.netflint.net/sets/icqG.jisp
	http://jisp.netflint.net/sets/individual.jisp
	http://jisp.netflint.net/sets/kitty.jisp
	http://jisp.netflint.net/sets/neos.jisp
	http://jisp.netflint.net/sets/puyo.jisp
	http://jisp.netflint.net/sets/raro.jisp
	http://jisp.netflint.net/sets/rss.jisp
	http://jisp.netflint.net/sets/speechbubbles.jisp
	http://jisp.netflint.net/sets/squareheads.jisp
	http://jisp.netflint.net/sets/tlen.jisp
	http://jisp.netflint.net/sets/weather.jisp
	http://jisp.netflint.net/sets/wpk.jisp
	"

SRC_URI="${SMILEYS}${ICONSETS}"

DESCRIPTION="Iconsets for Psi, a QT 3.x Jabber Client"
HOMEPAGE="http://psi.affinix.com/ http://jisp.netflint.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

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

