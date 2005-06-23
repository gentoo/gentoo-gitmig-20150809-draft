# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/openclipart/openclipart-0.12.ebuild,v 1.1 2005/06/23 20:59:40 smithj Exp $

inherit eutils

DESCRIPTION="Open Clip Art Library (openclipart.org)"
HOMEPAGE="http://www.openclipart.org/"
SRC_URI="http://www.openclipart.org/downloads/${PV}/${P}.tar.bz2"

LICENSE="public-domain" # creative commons
SLOT="0"
KEYWORDS="~x86"
IUSE="doc svg png pdf wmf gzip"

# we don't really need anything to run, but compression is optionally needed
DEPEND=""
RDEPEND=""

# suggested basedir for cliparts
CLIPART="/usr/share/clipart/${PN}"

select_files() {
	# select wanted formats, optionally compress them

	local FILE SVG="" PNG="" PDF="" DOC="" COMPRESS=""
	use svg && SVG="svg"
	use png && PNG="png"
	use pdf && PDF="pdf"
	use wmf && WMF="wmf"
	use doc && DOC="doc"
	use gzip && COMPRESS="yes"

	find "$1" -type f -mindepth 1 -maxdepth 1 | while read FILE
	do
		local NAME="${FILE%.*}" EXT="${FILE//*.}" YES=0
		if [ -n "$EXT" ]
		then
			if [ "$SVG" = "$EXT" -o "$PNG" = "$EXT" -o "$PDF" = "$EXT" -o "$WMF" = "$EXT" ]
			then
				if [ "$SVG" = "$EXT" -a -n "$COMPRESS" ]  # compress SVG
				then
					gzip -9 < "${FILE}" > "${FILE}z" && echo "${FILE}z"
				else
					echo "${FILE}"
				fi
				if [ -n "$DOC" -a -f "${NAME}.txt" ]  # if clipart has a description ...
				then
					gzip -9 "${NAME}.txt" && echo "${NAME}.txt.gz"  # ... then compress it always
				fi
				YES=1
			fi
		fi
		if [ $YES -eq 1 -a -f "${1}/README" ]
		then
			gzip -9 "${1}/README" && echo "${1}/README.gz"
		fi
	done | sort -u  # kill dupes
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	local DIR FILES
	dodoc LICENSE.txt README.txt
	find -type d | sort | while read DIR
	do
		FILES=$(select_files "$DIR")
		if [ -n "${FILES}" ]
		then
			einfo "Installing ${DIR#*/}"
			insinto "${CLIPART}/${DIR#*/}"
			doins ${FILES}
		fi
	done
}
