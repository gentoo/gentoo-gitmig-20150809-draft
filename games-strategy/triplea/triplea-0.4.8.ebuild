# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/triplea/triplea-0.4.8.ebuild,v 1.3 2004/12/10 03:17:17 mr_bones_ Exp $

inherit games

MY_PV=${PV//\./_}

DESCRIPTION="An open source clone of the popular Axis and Allies boardgame"
HOMEPAGE="http://triplea.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}_source_${MY_PV}.zip"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc"
SLOT="0"
IUSE="jikes"

RDEPEND="|| (
	>=virtual/jdk-1.4
	>=virtual/jre-1.4 )"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=dev-java/ant-core-1.4.1
	dev-java/junit
	jikes? ( >=dev-java/jikes-1.17 )"

S="${WORKDIR}/${PN}_${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# The sourcecode currently assumes the game is being run from a directory
	# one level below the installation root.
	cat >"${T}/${PN}" <<-EOF
		#!/bin/sh

		cd "${GAMES_DATADIR}/${PN}/lib"
		java -cp \\
			../data:../lib/plastic-1.2.0.jar:../lib/${P}.jar \\
			games.strategy.engine.framework.GameRunner
	EOF

	# Repair bad path in .ant.properties (bug #47437)
	sed -i \
		-e "/^junit.jar/s:=.*:=/usr/share/junit/lib/junit.jar:" \
			.ant.properties \
			|| die "sed .ant.properties failed"
	# The default savedGames directory is in the install root.  This
	# sets it to use the users home directory.
	echo "triplea.saveGamesInHomeDir=true" > data/triplea.properties
}

src_compile() {
	local antflags=

	if [ -z "$JAVA_HOME" ]; then
		einfo
		einfo "\$JAVA_HOME not set!"
		einfo "Please use java-config to configure your JVM and try again."
		einfo
		die "\$JAVA_HOME not set."
	fi

	if use jikes ; then
		antflags="-Dbuild.compiler=jikes"
	fi

	ant ${antflags} || die "compile problem"
	jar cf "lib/${P}.jar" -C classes . || die "jar problem"
}

src_install () {
	dogamesbin "${T}/${PN}" || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R data/ games/ lib/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	prepgamesdirs
}
