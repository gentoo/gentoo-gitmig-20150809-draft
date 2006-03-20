# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alephone/alephone-20051119.ebuild,v 1.2 2006/03/20 22:07:29 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="An enhanced version of the game engine from the classic Mac game, Marathon"
HOMEPAGE="http://source.bungie.org/"
SRC_URI="mirror://sourceforge/marathon/AlephOne-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lua opengl speex"

DEPEND="lua? ( dev-lang/lua )
	opengl? ( virtual/opengl )
	speex? ( media-libs/speex )
	dev-libs/boost
	>=media-libs/libsdl-1.2
	media-libs/sdl-image
	media-libs/sdl-net"

S=${WORKDIR}/AlephOne-${PV}

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/alephone.png ${S}
	cat > ${S}/alephone.sh << EOF
#!/bin/sh

DATADIRS="
/usr/local/share/AlephOne
/usr/local/share/games/AlephOne
/opt/AlephOne/share/AlephOne
/opt/AlephOne/share/games/AlephOne
/opt/alephone/share/AlephOne
/opt/alephone/share/games/AlephOne
/usr/share/AlephOne
/usr/share/games/AlephOne"

DIR=\$(dirname \${0})
CMD=\$(basename \${0})
ALEPHONE=\${CMD%%-*}
GAME=\${CMD#*-}
GAME=\${GAME%.*}

if [ -n "\${ALEPHONE_DATA}" ]
then
	export ALEPHONE_DATA=\${ALEPHONE_DATA}:${GAMES_DATADIR}/alephone-\${GAME}
elif [ "\${ALEPHONE}" == "alephone" ]
then
	export ALEPHONE_DATA=${GAMES_DATADIR}/AlephOne:${GAMES_DATADIR}/alephone-\${GAME}
else
	for d in \${DATADIRS}
	do
		if [ -d \${d} ]
		then
			export ALEPHONE_DATA=\${d}:${GAMES_DATADIR}/alephone-\${GAME}
			break
		fi
	done
	if [ -z "\${ALEPHONE_DATA}" ]
	then
		echo "Could not find the \${ALEPHONE} data directory in \${DATADIRS}"
		echo "Please set your ALEPHONE_DATA variable to point to the correct location of the data directory for \${ALEPHONE}"
		export ALEPHONE_DATA=${GAMES_DATADIR}/alephone-\${GAME}
	fi
fi

\${DIR}/\${ALEPHONE} -m $*
EOF
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable opengl) || die
	if ! use lua ; then
		# stupid configure script doesnt have an option
		dosed -i \
			-e '/HAVE_LUA/d' config.h \
			|| die "sed HAVE_LUA"
		dosed -i \
			-e '/^LIBS/s:-llua -llualib::' $(find -name Makefile) \
			|| die "sed -llua"
	fi
	if ! use speex ; then
		# stupid configure script doesnt have an option
		dosed -i \
			-e '/SPEEX/d:' config.h \
			|| die "sed SPEEX"
		dosed -i \
			-e '/^LIBS/s:-lspeex::' $(find -name Makefile) \
			|| die "sed -lspeex"
	fi
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dogamesbin alephone.sh || die "failed to install wrapper"
	dodoc AUTHORS README docs/Cheat_Codes
	dohtml docs/MML.html
	doicon alephone.png
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Read the docs and install the data files accordingly to play."
	echo
}
