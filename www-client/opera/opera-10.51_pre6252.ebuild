# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/opera/opera-10.51_pre6252.ebuild,v 1.1 2010/03/21 23:22:37 jer Exp $

EAPI="2"

OPREFIX="/usr/lib"

inherit eutils

DESCRIPTION="A standards-compliant graphical Web browser"
HOMEPAGE="http://www.opera.com/"

SLOT="0"
LICENSE="OPERA-10.10 LGPL-2"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

RESTRICT="mirror test"

QA_DT_HASH="${OPREFIX}/${PN}/.*"
QA_PRESTRIPPED="${OPREFIX}/${PN}/.*"

IUSE="elibc_FreeBSD"

MY_LINGUAS="
	be bg cs da de el en-GB es-ES es-LA et fi fr fr-CA fy hi hr hu id it ja ka
	ko lt mk nb nl nn pl pt pt-BR ro ru sk sr sv ta te tr uk zh-CN zh-HK zh-TW
"

for MY_LINGUA in ${MY_LINGUAS}; do
	IUSE="${IUSE} linguas_${MY_LINGUA/-/_}"
done

O_U="http://snapshot.opera.com/unix/snapshot-${PV/*_pre}/"
O_P="${P/_pre/-}"

SRC_URI="
	amd64? ( ${O_U}${O_P}.x86_64.linux.tar.bz2 )
	ppc? ( ${O_U}${O_P}.ppc.linux.tar.bz2 )
	x86? ( ${O_U}${O_P}.i386.linux.tar.bz2 )
	x86-fbsd? ( ${O_U}${O_P}.i386.freebsd.tar.bz2 )
"

DEPEND=">=sys-apps/sed-4"

RDEPEND="
	=x11-libs/gtk+-2*
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/glitz
	media-plugins/gst-plugins-meta
	media-libs/libpng
	sys-apps/util-linux
	sys-libs/zlib
	virtual/opengl
	x11-libs/cairo
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libxcb
	x11-libs/pango
	x11-libs/pixman
	x11-libs/xcb-util
	"

opera_linguas() {
	# Remove unwanted LINGUAS:
	local LINGUA
	local LNGDIR="${D}usr/share/${PN}/locale"
	einfo "Keeping these locales: ${LINGUAS}."
	for LINGUA in ${MY_LINGUAS}; do
		if ! use linguas_${LINGUA/-/_}; then
			LINGUA=$(find "${LNGDIR}" -maxdepth 1 -type d -iname ${LINGUA/_/-})
			rm -r "${LINGUA}"
		fi
	done
}

pkg_setup() {
	echo -e \
		" ${GOOD}****************************************************${NORMAL}"
	elog "If you seek support, please file a bug report at"
	elog "https://bugs.gentoo.org and post the output of"
	elog " \`emerge --info =${CATEGORY}/${P}'"
	echo -e \
		" ${GOOD}****************************************************${NORMAL}"
}

src_unpack() {
	unpack ${A}
	if [[ ! -d ${S} ]]; then
		cd "${WORKDIR}"/${PN}* || die "failed to enter work directory"
		S="$(pwd)"
		einfo "Setting WORKDIR to ${S}"
	fi
}

src_install() {
	# This alpha build hardcodes /usr as prefix
	dodir /usr
	mv lib/ share/ "${D}"/usr/ || die "mv etc/ usr/ failed"

	make_desktop_entry ${PN} Opera ${PN} # TODO

	# Install startup script
	dobin ${PN}-widget-manager "${FILESDIR}"/opera || die "dobin failed"

	# Stop revdep-rebuild from checking opera binaries
	dodir /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=\"${OPREFIX}/${PN}\"" > "${D}"/etc/revdep-rebuild/90opera

	# Change libz.so.3 to libz.so.1 for gentoo/freebsd
	if use elibc_FreeBSD; then
		scanelf -qR -N libz.so.3 -F "#N" "${D}"${OPREFIX}/${PN}/ | \
		while read i; do
			if [[ $(strings "$i" | fgrep -c libz.so.3) -ne 1 ]];
			then
				export SANITY_CHECK_LIBZ_FAILED=1
				break
			fi
			sed -i -e 's/libz\.so\.3/libz.so.1/g' "$i"
		done
		[[ "$SANITY_CHECK_LIBZ_FAILED" = "1" ]] && die "failed to change libz.so.3 to libz.so.1"
	fi

	[[ -z MY_LINGUAS ]] || opera_linguas
}

pkg_postinst() {
	elog "To change the UI language, choose [Tools] -> [Preferences], open the"
	elog "[General] tab, click on [Details...] then [Choose...] and point the"
	elog "file chooser at /usr/share/opera/locale/, then enter the"
	elog "directory for the language you want and [Open] the .lng file."

	if use elibc_FreeBSD; then
		elog
		elog "To improve shared memory usage please set:"
		elog "$ sysctl kern.ipc.shm_allow_removed=1"
	fi
}
