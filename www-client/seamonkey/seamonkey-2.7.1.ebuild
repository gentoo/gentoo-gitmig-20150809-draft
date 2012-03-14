# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/seamonkey/seamonkey-2.7.1.ebuild,v 1.4 2012/03/14 09:17:45 polynomial-c Exp $

EAPI="3"
WANT_AUTOCONF="2.1"

# This list can be updated with scripts/get_langs.sh from the mozilla overlay
MOZ_LANGS=(be ca cs de en-GB en-US es-AR es-ES fi fr gl hu it ja lt nb-NO nl pl
	    pt-PT ru sk sv-SE tr zh-CN)

MOZ_PV="${PV/_pre*}"
MOZ_PV="${MOZ_PV/_alpha/a}"
MOZ_PV="${MOZ_PV/_beta/b}"
MOZ_PV="${MOZ_PV/_rc/rc}"
MOZ_P="${PN}-${MOZ_PV}"

if [[ ${PV} == *_pre* ]] ; then
	MOZ_FTP_URI="ftp://ftp.mozilla.org/pub/${PN}/nightly/${MOZ_PV}-candidates/build${PV##*_pre}"
	MOZ_LANGPACK_PREFIX="linux-i686/xpi/"
	# And the langpack stuff stays at eclass defaults
else
	MOZ_FTP_URI="ftp://ftp.mozilla.org/pub/${PN}/releases/${MOZ_PV}"
	MOZ_LANGPACK_PREFIX="langpack/${MOZ_P}."
	MOZ_LANGPACK_SUFFIX=".langpack.xpi"
fi

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 multilib pax-utils fdo-mime autotools mozextension python nsplugins mozlinguas

PATCHFF="firefox-10.0-patches-0.5"
PATCH="${PN}-2.7-patches-03"
EMVER="1.3.5"

DESCRIPTION="Seamonkey Web Browser"
HOMEPAGE="http://www.seamonkey-project.org"

if [[ ${PV} == *_pre* ]] ; then
	# pre-releases. No need for arch teams to change KEYWORDS here.

	KEYWORDS=""
else
	# This is where arch teams should change the KEYWORDS.

	KEYWORDS="x86"
fi

SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="+alsa +chatzilla +crypt +ipc +roaming system-sqlite +webm"

SRC_URI+="${SRC_URI}
	${MOZ_FTP_URI}/source/${MOZ_P}.source.tar.bz2 -> ${P}.source.tar.bz2
	http://dev.gentoo.org/~anarchy/mozilla/patchsets/${PATCHFF}.tar.xz
	http://dev.gentoo.org/~anarchy/mozilla/patchsets/${PATCH}.tar.xz
	crypt? ( http://www.mozilla-enigmail.org/download/source/enigmail-${EMVER}.tar.gz )"

ASM_DEPEND=">=dev-lang/yasm-1.1"

# Mesa 7.10 needed for WebGL + bugfixes
RDEPEND=">=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.13.1
	>=dev-libs/nspr-4.8.9
	>=dev-libs/glib-2.26
	>=media-libs/mesa-7.10
	>=media-libs/libpng-1.4.1[apng]
	>=x11-libs/cairo-1.10
	>=x11-libs/pango-1.14.0
	>=x11-libs/gtk+-2.14
	virtual/libffi
	system-sqlite? ( >=dev-db/sqlite-3.7.7.1[fts3,secure-delete,unlock-notify,debug=] )
	crypt? ( >=app-crypt/gnupg-1.4 )
	webm? ( >=media-libs/libvpx-0.9.7
		media-libs/alsa-lib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	webm? ( amd64? ( ${ASM_DEPEND} )
		x86? ( ${ASM_DEPEND} ) )"

if [[ ${PV} == *beta* ]] ; then
	S="${WORKDIR}/comm-beta"
else
	S="${WORKDIR}/comm-release"
fi

src_unpack() {
	unpack ${A}

	# Unpack language packs
	mozlinguas_src_unpack
}

pkg_setup() {
	if [[ ${PV} == *_pre* ]] ; then
		ewarn "You're using an unofficial release of ${PN}. Don't file any bug in"
		ewarn "Gentoo's Bugtracker against this package in case it breaks for you."
		ewarn "Those belong to upstream: https://bugzilla.mozilla.org"
	fi

	moz_pkgsetup
}

src_prepare() {
	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/seamonkey"

	# browser patches go here
	pushd "${S}"/mozilla &>/dev/null || die
	EPATCH_EXCLUDE="2000-firefox_gentoo_install_dirs.patch" \
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/firefox"
	popd &>/dev/null || die

	# Allow user to apply any additional patches without modifing ebuild
	epatch_user

	if use crypt ; then
		mv "${WORKDIR}"/enigmail "${S}"/mailnews/extensions/enigmail
		cd "${S}"
	fi

	#Ensure we disable javaxpcom by default to prevent configure breakage
	sed -i -e s:MOZ_JAVAXPCOM\=1::g "${S}"/mozilla/xulrunner/confvars.sh \
		|| die "sed javaxpcom"

	# Disable gnomevfs extension
	sed -i -e "s:gnomevfs::" "${S}/"suite/confvars.sh \
		|| die "Failed to remove gnomevfs extension"

	eautoreconf
}

src_configure() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	MEXTENSIONS=""

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	if use chatzilla ; then
		MEXTENSIONS+=",irc"
	else
		MEXTENSIONS+=",-irc"
	fi
	if ! use roaming ; then
		MEXTENSIONS+=",-sroaming"
	fi

	mozconfig_annotate '' --prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --libdir="${EPREFIX}"/usr/$(get_libdir)
	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --disable-gconf
	mozconfig_annotate '' --enable-jsd
	mozconfig_annotate '' --enable-canvas
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --enable-system-ffi
	mozconfig_annotate '' --with-system-png
	mozconfig_annotate '' --target="${CTARGET:-${CHOST}}"

	mozconfig_use_enable system-sqlite
	mozconfig_use_enable methodjit

	# Use an objdir to keep things organized.
	echo "mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/seamonk" \
		>> "${S}"/.mozconfig

	# Finalize and report settings
	mozconfig_final

	# Work around breakage in makeopts with --no-print-directory
	MAKEOPTS="${MAKEOPTS/--no-print-directory/}"

	if [[ $(gcc-major-version) -lt 4 ]] ; then
		append-cxxflags -fno-stack-protector
	elif [[ $(gcc-major-version) -gt 4 || $(gcc-minor-version) -gt 3 ]] ; then
		if use amd64 || use x86 ; then
			append-flags -mno-avx
		fi
	fi
}

src_compile() {
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	MOZ_MAKE_FLAGS="${MAKEOPTS}" \
	emake -f client.mk || die

	# Only build enigmail extension if conditions are met.
	if use crypt ; then
		cd "${S}"/mailnews/extensions/enigmail || die
		./makemake -r 2&> /dev/null
		cd "${S}"/seamonk/mailnews/extensions/enigmail
		emake || die "make enigmail failed"
		emake xpi || die "make enigmail xpi failed"
	fi
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	declare emid
	local obj_dir="seamonk"
	cd "${S}/${obj_dir}"

	# Copy our preference before omnijar is created.
	sed "s|SEAMONKEY_PVR|${PVR}|" "${FILESDIR}"/all-gentoo-1.js > \
		"${S}/${obj_dir}/mozilla/dist/bin/defaults/pref/all-gentoo.js" \
		|| die

	pax-mark m "${S}"/dist/bin/xpcshell

	emake DESTDIR="${D}" install || die "emake install failed"
	cp -f "${FILESDIR}"/icon/${PN}.desktop "${T}" || die

	if use crypt ; then
		cd "${T}" || die
		unzip "${S}"/${obj_dir}/mozilla/dist/bin/enigmail*.xpi install.rdf || die
		emid=$(sed -n '/<em:id>/!d; s/.*\({.*}\).*/\1/; p; q' install.rdf)

		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		cd "${D}"${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		unzip "${S}"/${obj_dir}/mozilla/dist/bin/enigmail*.xpi || die

		cd "${S}" || die
	fi

	sed 's|^\(MimeType=.*\)$|\1text/x-vcard;text/directory;application/mbox;message/rfc822;x-scheme-handler/mailto;|' \
		-i "${T}"/${PN}.desktop || die
	sed 's|^\(Categories=.*\)$|\1Email;|' -i "${T}"/${PN}.desktop \
		|| die

	# Install language packs
	mozlinguas_src_install

	# Add StartupNotify=true bug 290401
	if use startup-notification ; then
		echo "StartupNotify=true" >> "${T}"/${PN}.desktop
	fi

	# Install icon and .desktop for menu entry
	newicon "${S}"/suite/branding/nightly/content/icon64.png ${PN}.png \
		|| die
	domenu "${T}"/${PN}.desktop || die

	# Required in order to use plugins and even run seamonkey on hardened.
	pax-mark m "${ED}"${MOZILLA_FIVE_HOME}/{seamonkey,seamonkey-bin,plugin-container}

	# Handle plugins dir through nsplugins.eclass
	share_plugins_dir

	doman "${S}"/${obj_dir}/suite/app/${PN}.1 || die
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="${ROOT}/usr/$(get_libdir)/${PN}"

	if [ -d ${MOZILLA_FIVE_HOME}/plugins ] ; then
		rm ${MOZILLA_FIVE_HOME}/plugins -rf
	fi
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update

	if use chatzilla ; then
		elog "chatzilla is now an extension which can be en-/disabled and configured via"
		elog "the Add-on manager."
	fi
}
