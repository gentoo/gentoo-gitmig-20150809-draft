# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/triplea/triplea-0.3.3.ebuild,v 1.2 2004/03/22 20:11:28 dholm Exp $

inherit games

MY_PV=${PV//\./_}
S="${WORKDIR}/${PN}_${MY_PV}"

DESCRIPTION="An open source clone of the popular Axis and Allies boardgame"
HOMEPAGE="http://triplea.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}_source_${MY_PV}.zip"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE="jikes"

RDEPEND="|| (
	>=virtual/jdk-1.4
	>=virtual/jre-1.4
	)"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	app-arch/unzip
	>=dev-java/ant-1.4.1
	dev-java/junit
	jikes? ( >=dev-java/jikes-1.17 )"


src_unpack() {
	unpack ${A}
	cd ${S}

	# Change saved games directory to ~/.triplea/savedGames
	sed -i \
		-e "/DEFAULT_DIRECTORY =/ s:GameRunner.getRootFolder():System.getProperties().get(\"user.home\") + \"/.triplea\":" \
		-e 's/DEFAULT_DIRECTORY.mkdir()/DEFAULT_DIRECTORY.mkdirs()/' \
			src/games/strategy/engine/framework/ui/SaveGameFileChooser.java \
				|| die "sed SaveGameFileChooser.java failed"
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

	if [ `use jikes` ] ; then
		antflags="-Dbuild.compiler=jikes"
	fi

	ant ${antflags} || die "compile problem"
	jar cf lib/${P}.jar -C classes . || die "jar problem"
}

src_install () {
	# The sourcecode currently assumes the game is being run from a directory
	# one level below the installation root.
	cat >"${T}/${PN}" <<-EOF
		#!/bin/sh

		cd "${GAMES_DATADIR}/${PN}/lib"
		java -mx96M -cp \\
		    ../data:../lib/plastic-1.2.0.jar:../lib/${P}.jar \\
		    games.strategy.engine.framework.GameRunner
	EOF
	dogamesbin "${T}/${PN}" || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R data/ games/ lib/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	prepgamesdirs
}
