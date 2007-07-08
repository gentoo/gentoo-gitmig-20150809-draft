# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/childsplay/childsplay-0.83.1.ebuild,v 1.4 2007/07/08 09:35:57 tupone Exp $

inherit games python

DESCRIPTION="A suite of educational games for young children"
HOMEPAGE="http://childsplay.sourceforge.net/"
PLUGINS_VERSION="0.83"
PLUGINS_LFC_VERSION="0.80.4"
SRC_URI="mirror://sourceforge/childsplay/${P}.tgz
	mirror://sourceforge/childsplay/${PN}_plugins-${PLUGINS_VERSION}.tgz
	mirror://sourceforge/childsplay/${PN}_plugins_lfc-${PLUGINS_LFC_VERSION}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.1
	>=dev-python/pygame-1.7.1
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-ttf-2.0
	>=media-libs/sdl-mixer-1.2
	media-libs/libogg"

src_unpack() {
	# Copy the plugins into the main package.
	unpack ${A}
	PLUGINSDIR="${PN}_plugins-${PLUGINS_VERSION}"
	PLUGINSLFCDIR="${PN}_plugins_lfc-${PLUGINS_LFC_VERSION}"
	for DIR in ${PLUGINSDIR} ${PLUGINSLFCDIR}; do
		cp -r ${DIR}/Data/*.icon.png ${P}/Data/icons
		cp -r ${DIR}/lib/* ${P}/lib
		cp -r ${DIR}/assetml/* ${P}/assetml
	done
	cp -r ${PLUGINSDIR}/Data/AlphabetSounds ${P}/Data
	cp ${PLUGINSDIR}/add-score.py ${P}

#	cd "${S}"
#	epatch "${FILESDIR}/letters-trans-path.patch"
}

src_install() {

	# The following variables are based on Childsplay's INSTALL.sh
	_LOCALEDIR=/usr/share/locale
	_ASSETMLDIR=/usr/share/assetml
	_SCOREDIR=${GAMES_STATEDIR}
	_SCOREFILE=${_SCOREDIR}/childsplay.score
	_CPDIR=$(games_get_libdir)/childsplay
	_SHAREDIR=${GAMES_DATADIR}/childsplay
	_LIBDIR=${_CPDIR}/lib
	_MODULESDIR=${_LIBDIR}
	_SHARELIBDATADIR=${_SHAREDIR}/lib
	_SHAREDATADIR=${_SHAREDIR}/Data
	_RCDIR=${_SHARELIBDATADIR}/ConfigData
	_HOME_DIR_NAME=.childsplay
	_CHILDSPLAYRC=childsplayrc

	dodir ${_CPDIR}
	dodir ${_LIBDIR}
	dodir ${_SHAREDIR}
	dodir ${_SHARELIBDATADIR}
	dodir ${_SCOREDIR}
	dodir ${_LOCALEDIR}
	dodir ${_ASSETMLDIR}

	# create BASEPATH.py
	cat >BASEPATH.py <<EOF
## Automated file--please do not edit
LOCALEDIR="${_LOCALEDIR}"
ASSETMLDIR="${_ASSETMLDIR}"
SCOREDIR="${_SCOREDIR}"
SCOREFILE="${_SCOREFILE}"
CPDIR="${_CPDIR}"
SHAREDIR="${_SHAREDIR}"
LIBDIR="${_LIBDIR}"
MODULESDIR="${_MODULESDIR}"
SHARELIBDATADIR="${_SHARELIBDATADIR}"
SHAREDATADIR="${_SHAREDATADIR}"
RCDIR="${_RCDIR}"
HOME_DIR_NAME="${_HOME_DIR_NAME}"
CHILDSPLAYRC="${_CHILDSPLAYRC}"
EOF

	# copy software and data
	cp -r *.py ${D}/${_CPDIR}
	cp -r Data ${D}/${_SHAREDIR}
	rm ${D}/${_SHAREDIR}/Data/childsplay.score  # this copy won't be used

	for fn in $(ls lib); do
		if [[ -d lib/${fn} ]] ; then
			cp -r lib/${fn} ${D}/${_SHARELIBDATADIR}
		else
			cp lib/${fn} ${D}/${_LIBDIR}
		fi
	done

	cp -r locale/* ${D}/${_LOCALEDIR}
	cp -r assetml/* ${D}/${_ASSETMLDIR}

	# initialize the score file
	cp Data/childsplay.score ${D}/${_SCOREFILE}
	SCORE_GAMES="Packid,Numbers,Soundmemory,Fallingletters,Findsound,Findsound2,Billiard"
	python add-score.py ${D}/${_SCOREDIR} $SCORE_GAMES

	# translate for the letters game
	python letters-trans.py ${D}/${_ASSETMLDIR}

	doman man/childsplay.6.gz
	dodoc doc/README* doc/Changelog doc/copyright

	# Make a launcher.
	dogamesbin ${FILESDIR}/childsplay
	dosed "s:GENTOO_DIR:${_CPDIR}:" ${GAMES_BINDIR}/childsplay

	prepgamesdirs
	fperms g+w ${_SCOREFILE}
}

pkg_postinst() {
	python_mod_optimize ${_CPDIR}
}

pkg_postrm() {
	python_mod_cleanup ${_CPDIR}
}
