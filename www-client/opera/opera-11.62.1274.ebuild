# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/opera/opera-11.62.1274.ebuild,v 1.2 2012/02/03 17:37:57 jer Exp $

EAPI="4"

inherit eutils fdo-mime gnome2-utils multilib pax-utils versionator

DESCRIPTION="A fast and secure web browser and Internet suite"
HOMEPAGE="http://www.opera.com/"

SLOT="0"
LICENSE="OPERA-11 LGPL-2 LGPL-3"
KEYWORDS="~amd64"
IUSE="elibc_FreeBSD gtk gtk3 kde +gstreamer"

O_V="$(get_version_component_range 1-2)" # Major version, i.e. 11.00
O_B="$(get_version_component_range 3)"   # Build version, i.e. 1156

O_D="ook_${O_V}-1273"
O_P="${PN}-${O_V}-${O_B}"
O_U="http://snapshot.opera.com/unix/"

SRC_URI="
	amd64? ( ${O_U}${O_D}/${O_P}.x86_64.linux.tar.xz )
"

OPREFIX="/usr/$(get_libdir)"

QA_DT_HASH="${OPREFIX}/${PN}/.*"
QA_PRESTRIPPED="${OPREFIX}/${PN}/.*"

O_LINGUAS="af az be bg bn cs da de el en-GB es-ES es-LA et fi fr fr-CA fy gd hi
hr hu id it ja ka ko lt me mk ms nb nl nn pa pl pt pt-BR ro ru sk sr sv sw ta te
th tl tr uk uz vi zh-CN zh-TW zu"

for O_LINGUA in ${O_LINGUAS}; do
	IUSE="${IUSE} linguas_${O_LINGUA/-/_}"
done

DEPEND="
	>=sys-apps/sed-4
	app-arch/xz-utils
"
GTKRDEPEND="
	dev-libs/atk
	dev-libs/glib:2
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	gtk? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	x11-libs/pango
	x11-libs/pixman
"
KDERDEPEND="
	kde-base/kdelibs
	x11-libs/qt-core
	x11-libs/qt-gui
"
GSTRDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2
	media-libs/gst-plugins-base
	media-libs/gstreamer
	media-plugins/gst-plugins-meta
"
RDEPEND="
	media-libs/fontconfig
	media-libs/freetype
	sys-apps/util-linux
	sys-libs/zlib
	virtual/opengl
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXrender
	x11-libs/libXt
	gtk? ( ${GTKRDEPEND} )
	gtk3? ( ${GTKRDEPEND} )
	kde? ( ${KDERDEPEND} )
	gstreamer? ( ${GSTRDEPEND} )
"
src_unpack() {
	unpack ${A}
	mv -v ${PN}* "${S}" || die
}

src_prepare() {
	local LNGDIR="share/${PN}/locale"

	# Count linguas
	count() { echo ${#}; }
	local lingua_count=$(count ${O_LINGUAS} en)
	local locale_count=$(count ${LNGDIR}/*)
	[[ ${lingua_count} = ${locale_count} ]] \
		|| die "Number of LINGUAS does not match number of locales"
	unset count

	# Remove unwanted linguas
	einfo "Keeping these locales (linguas): ${LINGUAS}."
	for LINGUA in ${O_LINGUAS}; do
		if ! use linguas_${LINGUA/-/_}; then
			LINGUA=$(find "${LNGDIR}" -maxdepth 1 -type d -iname ${LINGUA/_/-})
			rm -r "${LINGUA}" || die "The list of linguas needs to be fixed"
		fi
	done

	# Remove doc directory but keep the LICENSE under another name (bug #315473)
	mv share/doc/${PN}/LICENSE share/${PN}/defaults/license.txt
	rm -rf share/doc
	for locale in share/${PN}/locale/*; do
		rm -f "${locale}/license.txt"
		ln -sn /usr/share/${PN}/defaults/license.txt "${locale}/license.txt" \
			|| die
	done

	# Remove package directory
	rm -rf share/${PN}/package

	# Optional libraries
	if ! use gtk; then
		rm lib/${PN}/liboperagtk2.so || die
	fi
	if ! use gtk3; then
		rm lib/${PN}/liboperagtk3.so || die
	fi
	if ! use kde; then
		rm lib/${PN}/liboperakde4.so || die
	fi
	if ! use gstreamer; then
		rm -r lib/${PN}/gstreamer || die
	fi

	# Unzip the man pages before sedding
	gunzip share/man/man1/* || die

	# Replace PREFIX, SUFFIX and PN in various files
	sed -i \
		-e "s:@@{PREFIX}:/usr:g" \
		-e "s:@@{SUFFIX}::g" \
		-e "s:@@{_SUFFIX}::g" \
		-e "s:@@{USUFFIX}::g" \
		-e "s:opera:${PN}:g" \
		share/man/man1/* \
		share/applications/${PN}-*.desktop \
		|| die

	# Replace "Opera" with "Opera Next"
	if [[ ${PN} = opera-next ]]; then
		sed -i share/applications/${PN}-*.desktop \
			-e "/^Name=Opera\|^ Next/s:Opera:& Next:" || die
	fi

	# Create /usr/bin/opera wrapper
	echo '#!/bin/sh' > ${PN}
	echo 'export OPERA_DIR="/usr/share/'"${PN}"'"' >> ${PN}
	echo 'export OPERA_PERSONALDIR=${OPERA_PERSONALDIR:-"${HOME}/.'${PN}'"}' \
		>> ${PN}
	echo 'exec '"${OPREFIX}/${PN}/${PN}"' "$@"' >> ${PN}

	# Change libz.so.3 to libz.so.1 for gentoo/freebsd
	if use elibc_FreeBSD; then
		scanelf -qR -N libz.so.3 -F "#N" lib/${PN}/ | \
		while read i; do
			if [[ $(strings "$i" | fgrep -c libz.so.3) -ne 1 ]];
			then
				export SANITY_CHECK_LIBZ_FAILED=1
				break
			fi
			sed -i \
				"$i" \
				-e 's/libz\.so\.3/libz.so.1/g'
		done
		[[ "$SANITY_CHECK_LIBZ_FAILED" = "1" ]] && die
	fi
}

src_install() {
	# We install into usr instead of opt as Opera does not support the latter
	dodir /usr
	mv lib/ "${D}/${OPREFIX}" || die
	mv share/ "${D}/usr/" || die

	# Install startup scripts
	dobin ${PN}

	# Stop revdep-rebuild from checking opera binaries
	dodir /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=\"${OPREFIX}/${PN}\"" \
		> "${D}"/etc/revdep-rebuild/90${PN}

	# Set PaX markings for hardened/PaX (bug #344267)
	pax-mark m \
		"${D}/${OPREFIX}/${PN}/${PN}" \
		"${D}/${OPREFIX}/${PN}/operaplugincleaner" \
		"${D}/${OPREFIX}/${PN}/operapluginwrapper"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	if use elibc_FreeBSD; then
		elog
		elog "To improve shared memory usage please set:"
		elog "$ sysctl kern.ipc.shm_allow_removed=1"
	fi

	# Update desktop file database and gtk icon cache (bug #334993)
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	# Update desktop file database and gtk icon cache (bug #334993)
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}
