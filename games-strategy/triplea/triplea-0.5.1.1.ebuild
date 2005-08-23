# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/triplea/triplea-0.5.1.1.ebuild,v 1.2 2005/08/23 20:07:51 wolf31o2 Exp $

inherit eutils java-utils java-pkg games

MY_PV=${PV//\./_}
DESCRIPTION="An open source clone of the popular Axis and Allies boardgame"
HOMEPAGE="http://triplea.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}_source_${MY_PV}.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="jikes"

RDEPEND="|| (
	>=virtual/jdk-1.4
	>=virtual/jre-1.4 )"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=dev-java/ant-core-1.4.1
	>=dev-java/jgoodies-looks-bin-1.2.0
	dev-java/junit
	jikes? ( >=dev-java/jikes-1.17 )"

S="${WORKDIR}/${PN}_${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}.patch"

	cd lib/
	rm -f *.jar
	java-pkg_jar-from jgoodies-looks-bin
	cd ..


	cat > "${T}/${PN}" <<-EOF
		#!/bin/bash

		cd "${GAMES_DATADIR}/${PN}"
		java -Dtriplea.root="${GAMES_DATADIR}/${PN}" -cp \\
			triplea.jar:\$(java-config -p jgoodies-looks-bin) \\
			games.strategy.engine.framework.GameRunner
	EOF

	cat > "${T}/${PN}_ai" <<-EOF
		#!/bin/bash

		cd "${GAMES_DATADIR}/${PN}"
		java -Dtriplea.ai=true -Dtriplea.root="${GAMES_DATADIR}/${PN}" -cp \\
			triplea.jar:\$(java-config -p jgoodies-looks-bin) \\
			games.strategy.engine.framework.GameRunner
	EOF

	# Repair bad path in .ant.properties (bug #47437)
	sed -i \
		-e "/^junit.jar/s:=.*:=$(java-config -p junit):" \
			.ant.properties \
			|| die "sed .ant.properties failed"

	# The default savedGames directory is in the install root.  This
	# sets it to use the users home directory.
	echo "triplea.saveGamesInHomeDir=true" > triplea.properties
}

src_compile() {
	local antflags="jar"

	if use jikes ; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi

	ant ${antflags} || die "compile problem"
}

src_install () {
	dogamesbin \
		"${T}/${PN}" \
		"${T}/${PN}_ai" \
		|| die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R games/ triplea.jar "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	prepgamesdirs
}
