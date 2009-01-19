# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/openclipart/openclipart-0.18-r1.ebuild,v 1.5 2009/01/19 03:41:06 darkside Exp $

DESCRIPTION="Open Clip Art Library (openclipart.org)"
HOMEPAGE="http://www.openclipart.org/"

# Ugly stuff warning:
SRC_URI="svg? ( !wmf? ( !png? ( !pdf? ( !doc? (
			http://download.openclipart.org/downloads/${PV}/${P}-svgonly.tar.bz2
		) ) ) )
		png? ( http://download.openclipart.org/downloads/${PV}/${P}-full.tar.bz2 )
		pdf? ( http://download.openclipart.org/downloads/${PV}/${P}-full.tar.bz2 )
		wmf? ( http://download.openclipart.org/downloads/${PV}/${P}-full.tar.bz2 )
		doc? ( http://download.openclipart.org/downloads/${PV}/${P}-full.tar.bz2 )
	)
	!svg? ( http://download.openclipart.org/downloads/${PV}/${P}-full.tar.bz2 )"

LICENSE="public-domain" # creative commons
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc svg png pdf wmf gzip"

# We don't really need anything to run
DEPEND=""
RDEPEND=""

# Nothing to strip
RESTRICT="strip"

# suggested basedir for cliparts
CLIPART="/usr/share/clipart/${PN}"

src_unpack() {

	unpack "${A}"

	if ! use svg && ! use png && ! use pdf && ! use wmf; then
		ewarn "No image formats specified - defaulting to all"
	else
		! use pdf && MY_REMOVE="${MY_REMOVE} pdf"
		! use png && MY_REMOVE="${MY_REMOVE} png"
		! use svg && MY_REMOVE="${MY_REMOVE} svg"
		! use wmf && MY_REMOVE="${MY_REMOVE} wmf"
	fi

	! use doc && MY_REMOVE="${MY_REMOVE} txt"

	export MY_REMOVE

	MY_S="${WORKDIR}/openclipart-${PV}-"
	if use wmf || use png || use pdf || use doc || ! use svg; then
		MY_S="${MY_S}full"
	else
		MY_S="${MY_S}svgonly"
	fi
	export MY_S

	cd "${MY_S}/clipart/"
	einfo "Removing useless files..."

	find \
		\( -name "automatic" -o -name "move" -o -name "*.rdf" -o \
			-name "*.spec" -o -name "*.log" -o -name "*.sxd" -o \
			-name "*~" -o -name ".*.swp" \
		\) -exec rm -f {} \; || die "Failed"

	rm -f LICENSE.txt LOG.txt PASSFAIL README README.txt \
		TODO index.xml keywords.idx || die "Failed"

}

src_compile() {

	cd "${MY_S}/clipart/"
	for ext in ${MY_REMOVE}; do
		einfo "Removing files - ${ext}..."
		find -name "*.${ext}" -exec rm -f {} \; \
			|| die "Failed - remove"
	done

	if use gzip; then

		einfo "Compressing SVG files..."
		find -name "*.svg" -print0 | xargs -L 1 -0 \
			bash -c 'gzip -9c "${1}" > "${1}z"; rm -f "${1}"' --

	fi

	einfo "Compressing docs..."
	find \
		\( -name "*.txt" -o -name "README" -o -name "AUTHORS" -o \
			-name "COPYING" \
		\) -exec gzip -9 {} \; || die "Failed - compress docs"

}

src_install() {

	dodir "${CLIPART}" || die "Failed - dodir"

	cd "${MY_S}/clipart"
	find -type f -exec cp --parents {} "${D}/${CLIPART}" \; || \
		die "Failed - install"

	cd "${MY_S}"
	dodoc LICENSE README NEWS VERSION ChangeLog

}
