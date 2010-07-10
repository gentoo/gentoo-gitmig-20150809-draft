# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/opera/opera-10.70_pre6396.ebuild,v 1.1 2010/07/10 14:29:38 jer Exp $

EAPI="2"

inherit eutils multilib

DESCRIPTION="A standards-compliant graphical Web browser"
HOMEPAGE="http://www.opera.com/"

SLOT="0"
LICENSE="OPERA-10.53 LGPL-2 LGPL-3"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="elibc_FreeBSD gtk kde +gstreamer"

RESTRICT="mirror test"

OPREFIX="/usr/$(get_libdir)"

QA_DT_HASH="${OPREFIX}/${PN}/.*"
QA_PRESTRIPPED="${OPREFIX}/${PN}/.*"

MY_LINGUAS="
	be bg cs da de el en-GB es-ES es-LA et fi fr fr-CA fy hi hr hu id it ja ka
	ko lt mk nb nl nn pl pt pt-BR ro ru sk sr sv ta te tr uk vi zh-CN zh-HK
	zh-TW
"

for MY_LINGUA in ${MY_LINGUAS}; do
	IUSE="${IUSE} linguas_${MY_LINGUA/-/_}"
done

O_V="${PV/_pre/-}"
O_P="${PN}-${O_V}"
O_U="http://snapshot.opera.com/unix/ozone_${O_V}/"

SRC_URI="
	amd64? ( ${O_U}${O_P}.x86_64.linux.tar.bz2 )
	x86? ( ${O_U}${O_P}.i386.linux.tar.bz2 )
	x86-fbsd? ( ${O_U}${O_P}.i386.freebsd.tar.bz2 )
"

DEPEND=">=sys-apps/sed-4"

RDEPEND="
	gtk? (
		=x11-libs/gtk+-2*
		dev-libs/atk
		dev-libs/glib
		media-libs/glitz
		x11-libs/cairo
		x11-libs/pango
		x11-libs/pixman
	)
	kde? (
		kde-base/kdelibs
	)
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	gstreamer? ( media-plugins/gst-plugins-meta )
	sys-apps/util-linux
	sys-libs/zlib
	virtual/opengl
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
	x11-libs/xcb-util
	"

opera_linguas() {
	# Remove unwanted LINGUAS:
	local LINGUA
	local LNGDIR="share/${PN}/locale"
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

src_prepare() {
	# Remove "license directory" (bug #315473)
	rm -rf "share/doc/opera"

	# Leave libopera*.so only if the user chooses
	if ! use gtk; then
		rm lib/opera/liboperagtk.so || die "rm liboperagtk.so failed"
	fi
	if ! use kde; then
		rm lib/opera/liboperakde4.so || die "rm liboperakde4.so failed"
	fi

	# Unzip the man pages before sedding
	gunzip share/man/man1/* || die "gunzip failed"

	# Replace PREFIX and SUFFIX in various files
	sed -i \
		-e "s:@@{PREFIX}:/usr:g" \
		-e "s:@@{SUFFIX}::g" \
		-e "s:@@{_SUFFIX}::g" \
		-e "s:@@{USUFFIX}::g" \
		share/mime/packages/opera-widget.xml \
		share/man/man1/* \
		share/applications/opera-browser.desktop \
		share/applications/opera-widget-manager.desktop \
		|| die "sed failed"

	# Sed libdir in opera script
	sed "${FILESDIR}"/opera \
		-e "s|OPERA_LIBDIR|${OPREFIX}|g" > opera \
		|| die "sed opera script failed"

	# Sed libdir in defaults/pluginpath.ini
	sed -i \
		-e "s|/usr/lib32|${OPREFIX}|g" \
		share/opera/defaults/pluginpath.ini \
		|| die "sed pluginpath.ini failed"

	# Remove linguas only when the user sets no linguas
	[[ -z MY_LINGUAS ]] || opera_linguas

	# Change libz.so.3 to libz.so.1 for gentoo/freebsd
	if use elibc_FreeBSD; then
		scanelf -qR -N libz.so.3 -F "#N" lib/${PN}/ | \
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
}

src_install() {
	# We install into usr instead of opt as Opera does not support the latter
	dodir /usr
	mv lib/  "${D}/${OPREFIX}" || die "mv lib/ failed"
	mv share/ "${D}/usr/" || die "mv share/ failed"

	# Install startup scripts
	dobin ${PN} ${PN}-widget-manager || die "dobin failed"

	# Stop revdep-rebuild from checking opera binaries
	dodir /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=\"${OPREFIX}/${PN}\"" > "${D}"/etc/revdep-rebuild/90opera
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
